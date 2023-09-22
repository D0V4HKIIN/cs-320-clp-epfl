package amyc
package analyzer

import amyc.utils._
import amyc.ast.SymbolicTreeModule._
import amyc.ast.Identifier

// The type checker for Amy
// Takes a symbolic program and rejects it if it does not follow the Amy typing rules.
object TypeChecker
    extends Pipeline[(Program, SymbolTable), (Program, SymbolTable)] {

  def run(ctx: Context)(v: (Program, SymbolTable)): (Program, SymbolTable) = {
    import ctx.reporter._

    val (program, table) = v

    case class Constraint(found: Type, expected: Type, pos: Position)

    // Represents a type variable.
    // It extends Type, but it is meant only for internal type checker use,
    //  since no Amy value can have such type.
    case class TypeVariable private (id: Int) extends Type
    object TypeVariable {
      private val c = new UniqueCounter[Unit]
      def fresh(): TypeVariable = TypeVariable(c.next(()))
    }

    // Generates typing constraints for an expression `e` with a given expected type.
    // The environment `env` contains all currently available bindings (you will have to
    //  extend these, e.g., to account for local variables).
    // Returns a list of constraints among types. These will later be solved via unification.
    def genConstraints(e: Expr, expected: Type)(implicit
        env: Map[Identifier, Type]
    ): List[Constraint] = {

      // This helper returns a list of a single constraint recording the type
      //  that we found (or generated) for the current expression `e`
      def topLevelConstraint(found: Type): List[Constraint] =
        List(Constraint(found, expected, e.position))

      e match {
        case IntLiteral(_) =>
          topLevelConstraint(IntType)

        case Equals(lhs, rhs) =>
          // HINT: Take care to implement the specified Amy semantics
          val lhsAndRhsType = TypeVariable.fresh()
          val topLevel = topLevelConstraint(BooleanType)
          val lhsConstraints = genConstraints(lhs, lhsAndRhsType)
          val rhsConstraints = genConstraints(rhs, lhsAndRhsType)
          topLevel ++ lhsConstraints ++ rhsConstraints

        case Match(scrut, cases) =>
          // Returns additional constraints from within the pattern with all bindings
          // from identifiers to types for names bound in the pattern.
          // (This is analogous to `transformPattern` in NameAnalyzer.)
          def handlePattern(
              pat: Pattern,
              scrutExpected: Type
          ): (List[Constraint], Map[Identifier, Type]) = {
            pat match
              case WildcardPattern() =>
                (
                  Nil,
                  Map.empty
                )
              case IdPattern(name) =>
                (
                  Nil,
                  Map((name, scrutExpected))
                )
              case LiteralPattern(lit) =>
                (
                  genConstraints(lit, scrutExpected),
                  Map.empty
                )

              case CaseClassPattern(qualName, args) =>
                val constructor = table.getConstructor(qualName).get
                val argPatterns = args
                  .zip(constructor.argTypes)
                  .map(p => handlePattern(p._1, p._2))
                (
                  Constraint(
                    constructor.retType,
                    scrutExpected,
                    pat.position
                  ) :: argPatterns.unzip._1.flatten,
                  argPatterns.unzip._2.flatMap(_.toList).toMap
                )
          }

          def handleCase(
              cse: MatchCase,
              scrutExpected: Type
          ): List[Constraint] = {
            val (patConstraints, moreEnv) =
              handlePattern(cse.pat, scrutExpected)
            patConstraints ++ genConstraints(cse.expr, expected)(env ++ moreEnv)
          }

          val st = TypeVariable.fresh()
          genConstraints(scrut, st) ++ cases.flatMap(cse => handleCase(cse, st))

        // the other literals
        case BooleanLiteral(_) => topLevelConstraint(BooleanType)
        case StringLiteral(_)  => topLevelConstraint(StringType)
        case UnitLiteral()     => topLevelConstraint(UnitType)
        // variables
        case Variable(name) => topLevelConstraint(env(name))
        case Let(ParamDef(name, typeTree), value, body) =>
          val varType = TypeVariable.fresh()
          topLevelConstraint(varType) ++
            genConstraints(value, typeTree.tpe) ++ genConstraints(
              body,
              varType
            )(env + (name -> typeTree.tpe))

        // unary
        case Neg(arg) =>
          topLevelConstraint(IntType) ++ genConstraints(arg, IntType)
        case Not(arg) =>
          topLevelConstraint(BooleanType) ++ genConstraints(arg, BooleanType)

        // if then else
        case Ite(condition, thenBlock, elseBlock) =>
          genConstraints(condition, BooleanType) ++ genConstraints(
            thenBlock,
            expected
          ) ++ genConstraints(elseBlock, expected)

        // binary operations
        case Times(lhs, rhs) =>
          topLevelConstraint(IntType) ++ genConstraints(
            lhs,
            IntType
          ) ++ genConstraints(rhs, IntType)
        case Mod(lhs, rhs) =>
          topLevelConstraint(IntType) ++ genConstraints(
            lhs,
            IntType
          ) ++ genConstraints(rhs, IntType)
        case Div(lhs, rhs) =>
          topLevelConstraint(IntType) ++ genConstraints(
            lhs,
            IntType
          ) ++ genConstraints(rhs, IntType)
        case Plus(lhs, rhs) =>
          topLevelConstraint(IntType) ++ genConstraints(
            lhs,
            IntType
          ) ++ genConstraints(rhs, IntType)
        case Minus(lhs, rhs) =>
          topLevelConstraint(IntType) ++ genConstraints(
            lhs,
            IntType
          ) ++ genConstraints(rhs, IntType)
        // string
        case Concat(lhs, rhs) =>
          topLevelConstraint(StringType) ++ genConstraints(
            lhs,
            StringType
          ) ++ genConstraints(rhs, StringType)
        // boolean
        case LessThan(lhs, rhs) =>
          topLevelConstraint(BooleanType) ++ genConstraints(
            lhs,
            IntType
          ) ++ genConstraints(rhs, IntType)
        case LessEquals(lhs, rhs) =>
          topLevelConstraint(BooleanType) ++ genConstraints(
            lhs,
            IntType
          ) ++ genConstraints(rhs, IntType)
        case And(lhs, rhs) =>
          topLevelConstraint(BooleanType) ++ genConstraints(
            lhs,
            BooleanType
          ) ++ genConstraints(rhs, BooleanType)
        case Or(lhs, rhs) =>
          topLevelConstraint(BooleanType) ++ genConstraints(
            lhs,
            BooleanType
          ) ++ genConstraints(rhs, BooleanType)
        case Sequence(e1, e2) =>
          val e2Type = TypeVariable.fresh()
          topLevelConstraint(e2Type) ++ genConstraints(
            e1,
            TypeVariable.fresh()
          ) ++ genConstraints(e2, e2Type)

        // error
        case Error(errorMsg) =>
          topLevelConstraint(expected) ++ genConstraints(errorMsg, StringType);
        // function call
        case Call(qualifiedName, args) =>
          val (sign, newConstraint) = (
            table.getFunction(qualifiedName),
            table.getConstructor(qualifiedName)
          ) match {
            case (Some(s), None) =>
              (s, Constraint(s.retType, expected, e.position))
            case (None, Some(s)) =>
              (s, Constraint(ClassType(s.parent), expected, e.position))
            case _ => throw new scala.MatchError(e)
          }
          newConstraint :: (args
            .zip(sign.argTypes))
            .flatMap(pair => genConstraints(pair._1, pair._2))

      }
    }

    // Given a list of constraints `constraints`, replace every occurence of type variable
    //  with id `from` by type `to`.
    def subst_*(
        constraints: List[Constraint],
        from: Int,
        to: Type
    ): List[Constraint] = {
      // Do a single substitution.
      def subst(tpe: Type, from: Int, to: Type): Type = {
        tpe match {
          case TypeVariable(`from`) => to
          case other                => other
        }
      }

      constraints map { case Constraint(found, expected, pos) =>
        Constraint(subst(found, from, to), subst(expected, from, to), pos)
      }
    }

    // Solve the given set of typing constraints and report errors
    //  using `ctx.reporter.error` if they are not satisfiable.
    // We consider a set of constraints to be satisfiable exactly if they unify.
    def solveConstraints(constraints: List[Constraint]): Unit = {
      constraints match {
        case Nil                                      => ()
        case Constraint(found, expected, pos) :: more =>
          // HINT: You can use the `subst_*` helper above to replace a type variable
          //       by another type in your current set of constraints.
          (found, expected) match
            case (TypeVariable(id1), id2: TypeVariable) =>
              if (id1 == id2.id) solveConstraints(more)
              else solveConstraints(subst_*(more, id1, id2))
            case (TypeVariable(id), second) =>
              solveConstraints(Constraint(expected, found, pos) :: more)
            case (first, TypeVariable(id)) =>
              solveConstraints(subst_*(constraints, id, first))
            case (type1, type2) =>
              if (type1 == type2) solveConstraints(more)
              else
                error(
                  "Type error: expected: " ++ expected.toString ++ ", found: " ++ found.toString,
                  pos
                )
                solveConstraints(more)

      }
    }

    // Putting it all together to type-check each module's functions and main expression.
    program.modules.foreach { mod =>
      // Put function parameters to the symbol table, then typecheck them against the return type
      mod.defs.collect { case FunDef(_, params, retType, body) =>
        val env = params.map { case ParamDef(name, tt) => name -> tt.tpe }.toMap
        solveConstraints(genConstraints(body, retType.tpe)(env))
      }

      // Type-check expression if present. We allow the result to be of an arbitrary type by
      // passing a fresh (and therefore unconstrained) type variable as the expected type.
      val tv = TypeVariable.fresh()
      mod.optExpr.foreach(e => solveConstraints(genConstraints(e, tv)(Map())))
    }

    // this is really supposed to be here
    v

  }
}
