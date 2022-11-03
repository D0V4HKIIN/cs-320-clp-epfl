package amyc
package parsing

import scala.language.implicitConversions

import amyc.ast.NominalTreeModule._
import amyc.utils._
import Tokens._
import TokenKinds._

import scallion._
import scala.compiletime.ops.string

// The parser for Amy
object Parser extends Pipeline[Iterator[Token], Program] with Parsers {

  type Token = amyc.parsing.Token
  type Kind = amyc.parsing.TokenKind

  import Implicits._

  override def getKind(token: Token): TokenKind = TokenKind.of(token)

  val eof: Syntax[Token] = elem(EOFKind)
  def op(string: String): Syntax[Token] = elem(OperatorKind(string))
  def kw(string: String): Syntax[Token] = elem(KeywordKind(string))

  implicit def delimiter(string: String): Syntax[Token] = elem(
    DelimiterKind(string)
  )

  // An entire program (the starting rule for any Amy file).
  lazy val program: Syntax[Program] = many1(many1(module) ~<~ eof).map(ms =>
    Program(ms.flatten.toList).setPos(ms.head.head)
  )

  // A module (i.e., a collection of definitions and an initializer expression)
  lazy val module: Syntax[ModuleDef] =
    (kw("object") ~ identifier ~ many(definition) ~ opt(expr) ~ kw(
      "end"
    ) ~ identifier).map { case obj ~ id ~ defs ~ body ~ _ ~ id1 =>
      if id == id1 then ModuleDef(id, defs.toList, body).setPos(obj)
      else
        throw new AmycFatalError(
          "Begin and end module names do not match: " + id + " and " + id1
        )
    }

  // An identifier.
  val identifier: Syntax[String] = accept(IdentifierKind) {
    case IdentifierToken(name) => name
  }

  // An identifier along with its position.
  val identifierPos: Syntax[(String, Position)] = accept(IdentifierKind) {
    case id @ IdentifierToken(name) =>
      (name, id.position) // @ is the Scala pattern matching operator
  }

  // A definition within a module.
  lazy val definition: Syntax[ClassOrFunDef] =
    functionDefinition | abstractClassDefinition | caseClassDefinition

  lazy val functionDefinition: Syntax[ClassOrFunDef] =
    (kw("fn") ~ identifier ~ delimiter("(") ~ parameters ~ delimiter(
      ")"
    ) ~ delimiter(":") ~
      typeTree ~ delimiter("=") ~ delimiter("{") ~ expr ~ delimiter("}")).map {
      case kw1 ~ id ~ _ ~ params ~ _ ~ _ ~ retType ~ _ ~ _ ~ body ~ _ =>
        FunDef(id, params, retType, body).setPos(kw1)
    }
  lazy val abstractClassDefinition: Syntax[ClassOrFunDef] =
    (kw("abstract") ~ kw("class") ~ identifier).map { case kw ~ _ ~ id =>
      AbstractClassDef(id).setPos(kw)
    }
  lazy val caseClassDefinition: Syntax[ClassOrFunDef] =
    ((kw("case") ~ kw("class") ~ identifier ~ delimiter(
      "("
    ) ~ parameters ~ delimiter(")") ~ kw("extends") ~ identifier)).map {
      case kw ~ _ ~ id ~ _ ~ params ~ _ ~ _ ~ parent =>
        CaseClassDef(id, params.map(_._2), parent).setPos(kw)
    }
  // A list of parameter definitions.
  lazy val parameters: Syntax[List[ParamDef]] =
    repsep(parameter, ",").map(_.toList)

  // A parameter definition, i.e., an identifier along with the expected type.
  lazy val parameter: Syntax[ParamDef] =
    (identifier ~ delimiter(":") ~ typeTree).map { case id ~ kw ~ tpe =>
      ParamDef(id, tpe).setPos(kw)
    }

  // A type expression.
  lazy val typeTree: Syntax[TypeTree] = primitiveType | identifierType

  // A built-in type (such as `Int`).
  val primitiveType: Syntax[TypeTree] =
    (accept(PrimTypeKind) { case tk @ PrimTypeToken(name) =>
      TypeTree(name match {
        case "Unit"    => UnitType
        case "Boolean" => BooleanType
        case "Int"     => IntType
        case "String"  => StringType
        case _ =>
          throw new java.lang.Error("Unexpected primitive type name: " + name)
      }).setPos(tk)
    } ~ opt("(" ~ literal ~ ")")).map {
      case (prim @ TypeTree(IntType)) ~ Some(_ ~ IntLiteral(32) ~ _) => prim
      case TypeTree(IntType) ~ Some(_ ~ IntLiteral(width) ~ _) =>
        throw new AmycFatalError(
          "Int type can only be used with a width of 32 bits, found : " + width
        )
      case TypeTree(IntType) ~ Some(_ ~ lit ~ _) =>
        throw new AmycFatalError(
          "Int type should have an integer width (only 32 bits is supported)"
        )
      case TypeTree(IntType) ~ None =>
        throw new AmycFatalError(
          "Int type should have a specific width (only 32 bits is supported)"
        )
      case prim ~ Some(_) =>
        throw new AmycFatalError("Only Int type can have a specific width")
      case prim ~ None => prim
    }

  // A user-defined type (such as `List`).
  // should reject reserved words?:
  // true, false, case, class, abstract, object, types(int, string, ...). _ (wildcard)?
  lazy val identifierType: Syntax[TypeTree] =
    (identifierQualifiedName).map { case qualifiedName =>
      TypeTree(ClassType(qualifiedName))
    }

  lazy val identifierQualifiedName: Syntax[QualifiedName] =
    (identifier ~ opt(delimiter(".") ~ identifier)).map {
      case ident1 ~ Some(ident2) => // ident2 is a tuple (., ident)
        QualifiedName(Some(ident1), ident2._2)
      case identifier ~ None =>
        QualifiedName(None, identifier)
    }

  // An expression.
  // HINT: You can use `operators` to take care of associativity and precedence
  lazy val expr: Syntax[Expr] = recursive {
    prior1 // 14 fails
    // simpleExpr | prior2 | prior10 | prior9 | prior3to8  // not LL1
  }



  // A literal expression.
  lazy val literal: Syntax[Literal[_]] =
    otherLiteral

  // Unit literal
  // probably messes the LL1 property
  // lazy val unitLiteral: Syntax[Literal[_]] =
  //   (delimiter("(") ~ delimiter(")")).map { case kw => UnitLiteral() }

  // Literals that are not Units (LiteralKind)
  lazy val otherLiteral: Syntax[Literal[_]] =
    accept(LiteralKind) {
      case IntLitToken(value)    => IntLiteral(value)
      case StringLitToken(value) => StringLiteral(value)
      case BoolLitToken(value)   => BooleanLiteral(value)
    }

  // A pattern as part of a mach case.
  lazy val pattern: Syntax[Pattern] = { unitPattern | literalPattern | wildPattern }
     //literalPattern | wildPattern | unitPattern //| classPattern
  

  lazy val classPattern: Syntax[Pattern] =
    (identifier ~ opt(opt(delimiter(".") ~>~ identifier) ~<~ delimiter("(") ~ many(
      pattern
    ) ~<~ delimiter(")"))).map { 
      case ident1 ~ Some(Some(ident2) ~ seq) => CaseClassPattern(QualifiedName(Some(ident1), ident2), seq.toList)
      case ident1 ~ Some(None ~ seq) => CaseClassPattern(QualifiedName(None, ident1), seq.toList)
      case ident ~ None => IdPattern(ident)
    }
    
  lazy val unitPattern: Syntax[Pattern] =
    (delimiter("(") ~ delimiter(")")).map { case _ => LiteralPattern(UnitLiteral()) }

  // lazy val identifierPattern: Syntax[Pattern] =
  //   identifier.map(IdPattern(_))

  lazy val literalPattern: Syntax[Pattern] =
    literal.map(LiteralPattern(_))

//   accept(LiteralKind) {
//     case IntLitToken(value)    => LiteralPattern(IntLiteral(value))
//     case StringLitToken(value) => LiteralPattern(StringLiteral(value))
//     case BoolLitToken(value)   => LiteralPattern(BooleanLiteral(value))
//   }

  lazy val wildPattern: Syntax[Pattern] =
    (kw("_")).map { case kw =>
      WildcardPattern().setPos(kw)
    }

  // HINT: It is useful to have a restricted set of expressions that don't include any more operators on the outer level.

  lazy val prior1: Syntax[Expr] = varDef | expressionSequence
  lazy val prior2: Syntax[Expr] = matchStatement
  lazy val prior3to9: Syntax[Expr] = operation // maybe prior3to9
  // should maybe be removed cuz it maybe already in operation
  // lazy val prior9: Syntax[Expr] = prefixed // unary ops
  lazy val prior10: Syntax[Expr] = simpleExpr
  // throwError | variableOrCall | unitOrParExpr | otherLiteral
  // .up[Expr] // simpleExpr

  lazy val expressionSequence: Syntax[Expr] =
    (prior2 ~ opt(";" ~>~ expr)).map{
      case expr ~ None => expr
      case expr1 ~ Some(expr2) => Sequence(expr1, expr2)// expr.foldLeft(tail.head)((e1, e2) => Sequence(e1, e2))
    }

  lazy val matchStatement: Syntax[Expr] =
    ((prior3to9 | ifStatement) ~ many(kw("match") ~>~ delimiter("{") ~>~ many1(matchCase) ~<~ delimiter("}"))).map{
      case scrut ~ matches =>
        matches.toList match
          case head :: next => next.foldLeft(Match(scrut, head.toList))((z, x) => Match(z, x.toList))
          case Nil => scrut
    }


  lazy val matchCase: Syntax[MatchCase] =
    (kw("case") ~ pattern ~ delimiter("=>") ~ expr).map{
      case kw ~ pattern ~ del ~ expr => MatchCase(pattern, expr)
    }

  // interesting stuff: https://github.com/epfl-lara/scallion/blob/main/example/calculator/Calculator.scala

//e idea is to put expr of different priorities in different val, and surrounding ones with high priority with low priority. So simpleExpr is the one with highest priority, then the one follows is Unary, so u want sth like "Unary = opt(op(!) | Op(-))~simpleExpr"

  // copied and modified from doc: https://epfl-lara.github.io/scallion/scallion/Operators.html#prefixes[Op,A](op:Operators.this.Syntax[Op],elem:Operators.this.Syntax[A])(function:(Op,A)=%3EA,inverse:PartialFunction[A,(Op,A)]):Operators.this.Syntax[A]
  // val unaryOps: Syntax[String] = negative | not

  // i don't know if this should use simpleExpr
  
  lazy val prefixed: Syntax[Expr] = (opt(op("!") |  op("-"))  ~ simpleExpr).map {
    // Defines how to convert an `op` and an `expr` into an `expr`.
    case Some(op @ OperatorToken("-")) ~ expr => Neg(expr).setPos(op)
    case Some(op @ OperatorToken("!")) ~ expr => Not(expr).setPos(op)
    case None ~ sExpr => sExpr
  } 

  lazy val operation: Syntax[Expr] = recursive { // makes unary ops work idk
    operators(prefixed)(
      // Defines the different operators, by decreasing priority.
      // not could be Equals(False, rhs)
      // neg could be Minus(0, rhs) but how do we differenciate (a - b) and (-b)
      multiply | division | modulo is LeftAssociative,
      addition | substraction | concatenation is LeftAssociative,
      lessThan | lessEquals is LeftAssociative,
      equals is LeftAssociative,
      and is LeftAssociative,
      or is LeftAssociative
    ) {
      // Defines how to apply the various operators.
      case (lhs, "*", rhs) => Times(lhs, rhs).setPos(lhs)
      case (lhs, "/", rhs) => Div(lhs, rhs).setPos(lhs)
      case (lhs, "%", rhs) => Mod(lhs, rhs).setPos(lhs)

      case (lhs, "+", rhs)  => Plus(lhs, rhs).setPos(lhs)
      case (lhs, "-", rhs)  => Minus(lhs, rhs).setPos(lhs)
      case (lhs, "++", rhs) => Concat(lhs, rhs).setPos(lhs)

      case (lhs, "<", rhs)  => LessThan(lhs, rhs).setPos(lhs)
      case (lhs, "<=", rhs) => LessEquals(lhs, rhs).setPos(lhs)

      case (lhs, "==", rhs) => Equals(lhs, rhs).setPos(lhs)

      case (lhs, "&&", rhs) => And(lhs, rhs).setPos(lhs)

      case (lhs, "||", rhs) => Or(lhs, rhs).setPos(lhs)
    }
  }

  lazy val or: Syntax[String] = accept(OperatorKind("||")) { case _ =>
    "||"
  }

  lazy val and: Syntax[String] = accept(OperatorKind("&&")) { case _ =>
    "&&"
  }

  lazy val equals: Syntax[String] = accept(OperatorKind("==")) { case _ =>
    "=="
  }

  lazy val lessThan: Syntax[String] = accept(OperatorKind("<")) { case _ =>
    "<"
  }
  lazy val lessEquals: Syntax[String] = accept(OperatorKind("<=")) { case _ =>
    "<="
  }

  lazy val addition: Syntax[String] = accept(OperatorKind("+")) { case _ =>
    "+"
  }
  lazy val substraction: Syntax[String] = accept(OperatorKind("-")) { case _ =>
    "-"
  }
  lazy val concatenation: Syntax[String] = accept(OperatorKind("++")) {
    case _ =>
      "++"
  }

  lazy val multiply: Syntax[String] = accept(OperatorKind("*")) { case _ =>
    "*"
  }
  lazy val division: Syntax[String] = accept(OperatorKind("/")) { case _ =>
    "/"
  }
  lazy val modulo: Syntax[String] = accept(OperatorKind("%")) { case _ =>
    "%"
  }

  lazy val negative: Syntax[String] = accept(OperatorKind("-")) { case _ =>
    "-"
  }
  lazy val not: Syntax[String] = accept(OperatorKind("!")) { case _ =>
    "!"
  }

  // includes all of expr except binop and unaryop?
  lazy val simpleExpr: Syntax[Expr] =
    otherLiteral.up[Expr] | unitOrParExpr | variableOrCall | throwError // | ifStatement | varDef

  lazy val unitOrParExpr: Syntax[Expr] =
    (delimiter("(") ~ opt(expr) ~ delimiter(")")).map {
      case del1 ~ None ~ del2       => UnitLiteral().setPos(del1)
      case del1 ~ Some(expr) ~ del2 => expr
    }

  // id or function call
  lazy val variableOrCall: Syntax[Expr] =
    (identifier ~ opt(
      opt(delimiter(".") ~ identifier) ~ delimiter("(") ~ repsep(expr, ",") ~ delimiter(")")
    ))
      .map {
        case ident ~ None => Variable(ident)
        case ident ~ Some(None ~ kw1 ~ args ~ kw2) =>
          Call(QualifiedName(None, ident), args.toList)
        case ident1 ~ Some(Some(ident2) ~ kw1 ~ args ~ kw2) =>
          Call(QualifiedName(Some(ident1), ident2._2), args.toList)
      }

  // TODO: Other definitions.
  //       Feel free to decompose the rules in whatever way convenient.

  // variable definition
  lazy val varDef: Syntax[Expr] =
    (kw("val") ~ parameter ~ delimiter("=") ~ prior2 ~ delimiter(";") ~ expr)
      .map { case value ~ param ~ _ ~ expr1 ~ _ ~ expr2 =>
        Let(param, expr1, expr2).setPos(value)
      }

  // if then else statement
  lazy val ifStatement: Syntax[Expr] =
    (kw("if") ~ delimiter("(") ~ expr ~ delimiter(")") ~ delimiter("{")
      ~ expr ~ delimiter("}") ~ kw("else") ~ delimiter("{") ~ expr ~
      delimiter("}")).map {
      case _ ~ _ ~ boolExpr ~ _ ~ _ ~ trueExpr ~ _ ~ _ ~ _ ~ falseExpr ~ _ =>
        Ite(boolExpr, trueExpr, falseExpr)
    }

  // error( expr )
  lazy val throwError: Syntax[Expr] =
    (kw("error") ~ delimiter("(") ~ expr ~ delimiter(")")).map {
      case _ ~ _ ~ errExpr ~ _ =>
        Error(errExpr)
    }

  // Ensures the grammar is in LL(1)
  lazy val checkLL1: Boolean = {
    if (program.isLL1) {
      true
    } else {
      // Set `showTrails` to true to make Scallion generate some counterexamples for you.
      // Depending on your grammar, this may be very slow.
      val showTrails = true
      debug(program, showTrails)
      false
    }
  }

  override def run(ctx: Context)(tokens: Iterator[Token]): Program = {
    import ctx.reporter._
    if (!checkLL1) {
      ctx.reporter.fatal("Program grammar is not LL1!")
    }

    val parser = Parser(program)

    parser(tokens) match {
      case Parsed(result, rest) => result
      case UnexpectedEnd(rest)  => fatal("Unexpected end of input.")
      case UnexpectedToken(token, rest) =>
        fatal(
          "Unexpected token: " + token + ", possible kinds: " + rest.first
            .map(_.toString)
            .mkString(", ")
        )
    }
  }
}
