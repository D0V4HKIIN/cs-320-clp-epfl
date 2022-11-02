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
    lazy val functionDefinition: Syntax[ClassOrFunDef] =
      (kw("fn") ~ identifier ~ delimiter("(") ~ parameters ~ delimiter(")") ~ delimiter(":") ~
        typeTree ~ delimiter("=") ~ delimiter("{") ~ expr ~ delimiter("}")).map {
        case kw1 ~ id ~ _ ~ params ~ _ ~ _ ~ retType ~ _ ~ _ ~ body ~ _ =>
          FunDef(id, params, retType, body).setPos(kw1)
      }
    lazy val abstractClassDefinition: Syntax[ClassOrFunDef] =
      (kw("abstract") ~ kw("class") ~ identifier).map { case kw ~ _ ~ id =>
        AbstractClassDef(id).setPos(kw)
      }
    lazy val caseClassDefinition: Syntax[ClassOrFunDef] =
      ((kw("case") ~ kw("class") ~ identifier ~ delimiter("(") ~ parameters ~ delimiter(")") ~ kw("extends") ~ identifier)).map { 
        case kw ~ _ ~ id ~ _ ~ params ~ _ ~ _ ~ parent => CaseClassDef(id, params.map(_._2), parent).setPos(kw)
      }
    functionDefinition | abstractClassDefinition | caseClassDefinition

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
    (identifier ~ opt(kw(".") ~ identifier)).map {
      case ident1 ~ Some(ident2) => // ident2 is a tuple (., ident)
        QualifiedName(Some(ident1), ident2._2)
      case identifier ~ None =>
        QualifiedName(None, identifier)
    }

  // An expression.
  // HINT: You can use `operators` to take care of associativity and precedence
  lazy val expr: Syntax[Expr] = recursive {
    simpleExpr
  }

  // A literal expression.
  lazy val literal: Syntax[Literal[_]] =
    unitLiteral | otherLiteral

  // Unit litteral
  // probably messes the LL1 property
  lazy val unitLiteral: Syntax[Literal[_]] =
    (delimiter("(") ~ delimiter(")")).map { case kw => UnitLiteral() }

  // Litterals that are not Units (LiteralKind)
  lazy val otherLiteral: Syntax[Literal[_]] =
    accept(LiteralKind) {
      case IntLitToken(value)    => IntLiteral(value)
      case StringLitToken(value) => StringLiteral(value)
      case BoolLitToken(value)   => BooleanLiteral(value)
    }

  // A pattern as part of a mach case.
  lazy val pattern: Syntax[Pattern] = recursive {
    identifierPattern | literalPattern | wildPattern | classPattern
  }

  lazy val classPattern: Syntax[Pattern] =
    (identifierQualifiedName ~ kw("(") ~ many(
      pattern
    ) ~ kw(")")).map { case ident1 ~ kw1 ~ seq ~ kw2 =>
      CaseClassPattern(ident1, seq.toList)
    }

  lazy val identifierPattern: Syntax[Pattern] =
    identifier.map(IdPattern(_))

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
  // includes all of expr except binop and unaryop
  lazy val simpleExpr: Syntax[Expr] =
    literal.up[Expr] | variableOrCall | ifStatement | throwError // | parExpr

  // id or function call
  lazy val variableOrCall: Syntax[Expr] =
    (identifier ~ opt(
      opt(kw(".") ~ identifier) ~ kw("(") ~ many(expr) ~ kw(")")
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
    (kw("val") ~ parameter ~ kw("=") ~ expr ~ kw(";") ~ expr).map {
      case _ ~ param ~ _ ~ expr1 ~ _ ~ expr2 => Let(param, expr1, expr2)
    }

  // expression in parentheses
  lazy val parExpr: Syntax[Expr] = (kw("(") ~ expr ~ kw(")")).map {
    case _ ~ expr ~ _ => ???
  }

  // if then else statement
  lazy val ifStatement: Syntax[Expr] =
    (kw("if") ~ kw("(") ~ expr ~ kw(")") ~ kw("{") ~ expr ~ kw("}") ~ kw(
      "else"
    ) ~ kw("{") ~ expr ~ kw("}")).map {
      case _ ~ _ ~ boolExpr ~ _ ~ _ ~ trueExpr ~ _ ~ _ ~ _ ~ falseExpr ~ _ =>
        Ite(boolExpr, trueExpr, falseExpr)
    }

  // error( expr )
  lazy val throwError: Syntax[Expr] =
    (kw("error(") ~ expr ~ kw(")")).map { case _ ~ errExpr ~ _ =>
      Error(errExpr)
    }

  // Ensures the grammar is in LL(1)
  lazy val checkLL1: Boolean = {
    if (program.isLL1) {
      true
    } else {
      // Set `showTrails` to true to make Scallion generate some counterexamples for you.
      // Depending on your grammar, this may be very slow.
      val showTrails = false
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
