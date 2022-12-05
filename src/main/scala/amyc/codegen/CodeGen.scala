package amyc
package codegen

import analyzer._
import amyc.ast.Identifier
import amyc.ast.SymbolicTreeModule.{
  Call => AmyCall,
  Div => AmyDiv,
  And => AmyAnd,
  Or => AmyOr,
  _
}
import amyc.utils.{Context, Pipeline}
import wasm._
import Instructions._
import Utils._

// Generates WebAssembly code for an Amy program
// compile with run library/Std.amy [file]
object CodeGen extends Pipeline[(Program, SymbolTable), Module] {
  def run(ctx: Context)(v: (Program, SymbolTable)): Module = {
    val (program, table) = v

    // Generate code for an Amy module
    def cgModule(moduleDef: ModuleDef): List[Function] = {
      val ModuleDef(name, defs, optExpr) = moduleDef
      // Generate code for all functions
      defs.collect {
        case fd: FunDef if !builtInFunctions(fullName(name, fd.name)) =>
          cgFunction(fd, name, false)
      } ++
        // Generate code for the "main" function, which contains the module expression
        optExpr.toList.map { expr =>
          val mainFd =
            FunDef(Identifier.fresh("main"), Nil, TypeTree(IntType), expr)
          cgFunction(mainFd, name, true)
        }
    }

    // Generate code for a function in module 'owner'
    def cgFunction(fd: FunDef, owner: Identifier, isMain: Boolean): Function = {
      // Note: We create the wasm function name from a combination of
      // module and function name, since we put everything in the same wasm module.
      val name = fullName(owner, fd.name)
      Function(name, fd.params.size, isMain) { lh =>
        val locals = fd.paramNames.zipWithIndex.toMap
        val body = cgExpr(fd.body)(locals, lh)
        val comment = Comment(fd.toString)
        if (isMain) {
          body <:> Drop // Main functions do not return a value,
          // so we need to drop the value generated by their body
        } else {
          comment <:> body
        }
      }
    }

    // Generate code for an expression expr.
    // Additional arguments are a mapping from identifiers (parameters and variables) to
    // their index in the wasm local variables, and a LocalsHandler which will generate
    // fresh local slots as required.
    def cgExpr(
        expr: Expr
    )(implicit locals: Map[Identifier, Int], lh: LocalsHandler): Code = {
      expr match {
        // Literals
        case IntLiteral(i) =>
          // Push i to the stack.
          // The comments are optional but can help you debug.
          Comment(expr.toString) <:> Const(i)

        case BooleanLiteral(b) =>
          // Push b 1 or 0 to the stack
          if (b) then Comment(expr.toString) <:> Const(1)
          else Comment(expr.toString) <:> Const(0)

        case StringLiteral(s) => mkString(s) // already adds a comment

        case UnitLiteral() => Comment(expr.toString) <:> Const(0)

        // Variables
        // pushes the local (variable) to the stack
        case Variable(v) => Comment(expr.toString) <:> GetLocal(locals(v))

        // Binary operators
        case Plus(e1, e2) =>
          Comment(expr.toString) <:> cgExpr(e1) <:> cgExpr(e2) <:> Add
        case Minus(e1, e2) =>
          Comment(expr.toString) <:> cgExpr(e1) <:> cgExpr(e2) <:> Sub
        case Times(e1, e2) =>
          Comment(expr.toString) <:> cgExpr(e1) <:> cgExpr(e2) <:> Mul
        // see top of file at import
        // division by 0??
        case AmyDiv(e1, e2) =>
          Comment(expr.toString) <:> cgExpr(e1) <:> cgExpr(e2) <:> Div
        case Mod(e1, e2) =>
          Comment(expr.toString) <:> cgExpr(e1) <:> cgExpr(e2) <:> Rem
        case LessThan(e1, e2) =>
          Comment(expr.toString) <:> cgExpr(e1) <:> cgExpr(e2) <:> Lt_s
        case LessEquals(e1, e2) =>
          Comment(expr.toString) <:> cgExpr(e1) <:> cgExpr(e2) <:> Le_s
        case AmyAnd(e1, e2) =>
          Comment(expr.toString) <:> cgExpr(e1) <:> cgExpr(e2) <:> And
        case AmyOr(e1, e2) =>
          Comment(expr.toString) <:> cgExpr(e1) <:> cgExpr(e2) <:> Or
        case Equals(e1, e2) =>
          Comment(expr.toString) <:> cgExpr(e1) <:> cgExpr(e2) <:> Eq
        // call the string concat function
        case Concat(e1, e2) =>
          Comment(expr.toString) <:> cgExpr(e1) <:>
            cgExpr(e2) <:> Call("String_concat")

        // equals zero bc 1 => 0 and 0 => 1
        case Not(e) => Comment(expr.toString) <:> cgExpr(e) <:> Eqz
        // multiply by -1
        case Neg(e) =>
          Comment(expr.toString) <:> cgExpr(e) <:> Const(-1) <:> Mul

        // foldLeft to push all args to the stack
        // reverse because i prepend in foldLeft but we want the first arg to be the first added to the stack
        // might be wrong
        case AmyCall(qname, args) =>
          
          (table.getConstructor(qname), table.getFunction(qname)) match {
            case (None, Some(funSig)) => 
                  // if(funSig.retType == UnitType) {
                  //   Comment(expr.toString) <:>
                  //   args.foldLeft(List[Code]()) { case (acc, e) => cgExpr(e) :: acc }.reverse <:> 
                  //   Call(fullName(funSig.owner, qname)) <:> Drop
                  // } else {
                  Comment(expr.toString) <:>
                  args.foldLeft(List[Code]()) { case (acc, e) => cgExpr(e) :: acc }.reverse <:> 
                  Call(fullName(funSig.owner, qname))
                  // }
            
            case (Some(conSig), None) => {
              // get field adt field at index i
              // put argument on stack
              // store
              val argsCode = args.zipWithIndex.foldLeft(Code(List())){ case (acc, (arg, i)) => GetGlobal(memoryBoundary) <:> adtField(i) <:> cgExpr(arg) <:> Store <:> acc}
              
              // store constructor id to the memory boundary
              Comment(expr.toString) <:> GetGlobal(memoryBoundary) <:> Const(conSig.index) <:> Store <:>
              // put arguments after the id
              argsCode <:>
              // load the variable that's now at the mem boundary
              GetGlobal(memoryBoundary) <:>
              Load <:>
              // update memory boundary 4x for alignment. +1 for constructor id
              GetGlobal(memoryBoundary) <:> Const(4 * (1 + args.length)) <:> Add <:> SetGlobal(memoryBoundary)
            }
            case _ => {throw new Exception("bruh dude, dis call ain't good")}
          }

        // genereate code for left and right side. drop what e1 generated because it is not being consumed
        case Sequence(e1, e2) =>
          Comment(expr.toString) <:> cgExpr(e1) <:> Drop <:> cgExpr(e2)

        // push value to stack
        // set fresh local
        // generate code for the following code with new locals
        case Let(paramDef, value, body) =>
          val fresh = lh.getFreshLocal()
          Comment(expr.toString) <:> cgExpr(value) <:>
          SetLocal(fresh) <:>
          cgExpr(body)(locals + (paramDef.name -> fresh), lh)

        // push condition boolean to stack
        // if
        // then code
        // else
        // else code
        // end
        case Ite(condition, thenn, elze) =>
          Comment(expr.toString) <:> cgExpr(condition) <:>
          If_i32 <:> cgExpr(thenn) <:>
          Else <:> cgExpr(elze) <:>
          End

        case Match(scrut, cases) =>
          // Checks if a value matches a pattern.
          // Assumes value is on top of stack (and CONSUMES it)
          // Returns the code to check the value, and a map of bindings.

          // eval scrut
          // put in a local
          val scrutLocal = lh.getFreshLocal()
          cgExpr(scrut) <:> SetLocal(scrutLocal)
          // needs to be put onto the stack every time matchAndBind is called

          def matchAndBind(pat: Pattern): (Code, Map[Identifier, Int]) =
            pat match {
              case IdPattern(id) =>
                val idLocal = lh.getFreshLocal()
                (
                    Comment(pat.toString) <:>
                    // get scrutlocal because we do it on a per match case, bc wildcard doesn't need it
                    GetLocal(scrutLocal) <:>
                    // Assign val to id.
                    SetLocal(idLocal) <:>
                    // Return true (IdPattern always matches).
                    Const(1),
                    // Let the code generation of the expression which corresponds to this pattern
                    // know that the bound id is at local idLocal.
                    Map(id -> idLocal)
                )
              
              // wildcard pattern is always true
              case WildcardPattern() => (Comment(pat.toString) <:> Const(1),  Map.empty)

              // get scrut and litteral
              // compare equality
              case LiteralPattern(l) => (Comment(pat.toString) <:> GetLocal(scrutLocal) <:> cgExpr(l) <:> Eq, Map.empty)
              
              // [scrut pointer] stack
              // load
              // [scrutid] stack
              // push pattern case class id to the stack (Const)
              // [scrutid, patterncaseclassid] stack
              // Eq
              // And matchAndBind(args...) (probably be done outside)
              // map args
              case CaseClassPattern(constr, args) => 
                {
                  val caseClassSignature = table.getConstructor(constr).get

                  val matchNbinds = args.foldLeft(List[(Code, Map[Identifier, Int])]())((acc, arg) 
                    => {
                      val matchNbind = matchAndBind(arg)
                      (matchNbind._1 <:> And, matchNbind._2) :: acc}
                    )

                  val argsCode = matchNbinds.map(_._1)
                  val argsBinds = matchNbinds.map(_._2).flatten.toMap
                  
                  (Comment(pat.toString) <:> GetLocal(scrutLocal) <:> Load <:> Const(caseClassSignature.index) <:> Eq <:>
                   argsCode /* <:> "check args"*/, argsBinds /* map to change*/)
                }
            }

          cases.foldLeft(Code(List()))((acc, caze) => {
            val matchNbind = matchAndBind(caze.pat)
            val condition = matchNbind._1
            val matchBind = matchNbind._2
            
            Comment(expr.toString) <:> condition <:> If_i32 <:> cgExpr(caze.expr)(locals ++ matchBind, lh) <:> Else <:> acc 
          }) <:> Unreachable <:> cases.foldLeft(Code(List()))((acc, _) => acc <:> End)

        case _ => { println(expr.toString + " is not implemented"); ??? }
      }
    }

    Module(
      program.modules.last.name.name,
      defaultImports,
      globalsNo,
      wasmFunctions ++ (program.modules flatMap cgModule)
    )

  }
}
