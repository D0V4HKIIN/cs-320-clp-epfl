package amyc
package c

import scala.language.implicitConversions
import amyc.utils._
import c.Instructions._

// Printer for Wasm modules
object ModulePrinter {
  private implicit def s2d(s: String): Raw = Raw(s)

  private def mkMod(mod: Module): Document = Stacked(
    // "(module ",
    // Indented("(global (mut i32) i32.const 0) " * mod.globals),
    // ")"
    "#include <stdio.h>",
    "int a;",
    "#define push stack[stack_pointer++] = ",
    "#define pop stack[--stack_pointer]",
    "#define peek(i) stack[stack_pointer - i]",
    "#define cnst push ",
    "#define drop stack_pointer--",
    "#define getGlobal(i) push globals[i]",
    "#define setGlobal(i) globals[i] = pop",
    "#define getLocal(i) push locals[i]",
    "#define setLocal(i) locals[i] = pop",
    "#define store memory[stack[stack_pointer - 2]] = stack[stack_pointer - 1]; stack_pointer -= 2",
    "#define store8 memory[stack[stack_pointer - 2]] = stack[stack_pointer - 1] & 0x000000ffUL; stack_pointer -= 2",
    "#define load push memory[pop]",
    "#define load8 push *((char*)memory[pop])",


    "#define MAX_STACK_SIZE 10000",
    "int stack[MAX_STACK_SIZE];",
    "int stack_pointer = 0;",
    "int globals[MAX_STACK_SIZE];",
    "char memory[MAX_STACK_SIZE];\n",

    Stacked(mod.functions map decFun),
    Lined(List()), // newline
    Stacked(mod.imports map mkImport),
    Stacked(mod.functions map mkFun)

  )

  private def mkImport(s: String): Document = {
    // Lined(List("(import ", s, ")"))
    Lined(List(s))
  }

  private def decFun(fh: Function): Document = {
     Lined(List(Raw("void"), s" ${fh.name}();"))
  }
    
  private def mkFun(fh: Function): Document = {
    val isMain = fh.isMain
    val name = if isMain then "main" else fh.name
    
    // val exportDoc: Document = if (isMain) s"""(export "$name" (func $$$name))""" else ""
    // val paramsDoc: Document = if (fh.args == 0) "" else {
    //   Lined(List(
    //     Lined(fh.params.map(p => {println("int" + p); Raw("int") <:> p}), ", "),
    //   ))
    // }
    val resultDoc: Document = Raw("void")
    // val localsDoc: Document =
    //   if (fh.locals > 0)
    //     "(local " <:> Lined(List.fill(fh.locals)(Raw("i32")), " ") <:> ")"
    //   else
    //     ""

    Stacked(
      Lined(List(resultDoc, s" ${name}() {")),
        Indented(
          Lined(
            List(
              Raw(s"int locals[${fh.args + fh.locals}] = {"),
              Raw(
                (for i <- 0 until fh.args
                yield "pop").mkString(", ") + (if fh.args == 0 then "" else ", ")
              ),
              Raw(
                (for i <- 0 until fh.locals
                yield "0").mkString(", ")
              ),
              Raw("};")
            )
          )
        ),
        Indented(Stacked(mkCode(fh.code))),
      "}"
    )
  }

  private def mkCode(code: Code): List[Document] = code.instructions match {
    case Nil => Nil
    case h :: t => h match {
      case Else =>
        Unindented(mkInstr(h)) ::
        mkCode(t)
      case End =>
        Unindented(mkInstr(h)) ::
        (mkCode(t) map Unindented.apply)
      case If_void | If_i32 | Block(_) | Loop(_) =>
        mkInstr(h) ::
        (mkCode(t) map Indented.apply)
      case _ =>
        mkInstr(h) ::
        mkCode(t)
    }
  }

  private def mkInstr(instr: Instruction): Document = {
    instr match {
      case Const(value) => s"cnst $value;"
      case Add => "push (pop + pop);"
      case Sub => "a = pop; push (pop - a);" // first value is the one we substract
      case Mul => "push (pop * pop);"
      case Div => "a = pop; push (pop / a);" // first value is the one we divide by
      case Rem => "a = pop; push (pop % a);" // first value is the one we mod by
      case And => "push (pop && pop);"
      case Or  => "push (pop || pop);"
      case Eqz => "push (pop == 0);"
      case Lt_s => "a = pop; push (pop < a);" // inverse
      case Le_s => "a = pop; push (pop <= a);" // inverse
      case Eq => "push (pop == pop);"
      case Drop => "drop;"
      case If_void => "if (pop){"
      case If_i32 => "if (pop){"
      case Else => "} else {"
      case Block(label) => s"exit(2); //FUCK BLOCK { // is a block is brokey"
      case Loop(label) => s"$label: {"
      case Br(label)=> s"goto $label;"
      case Return => "return;"
      case End => "}"
      case Call(name) => s"$name();"
      case Unreachable => "exit(1);"
      case GetLocal(index) => s"getLocal($index);"
      case SetLocal(index) => s"setLocal($index);"
      case GetGlobal(index) => s"getGlobal($index);"
      case SetGlobal(index) => s"setGlobal($index);"
      case Store => "store;"
      case Load => "load;"
      case Store8 => "store; // store8"  //"i32.store8"
      case Load8_u => "load; // load8_u" //"i32.load8_u"
      case Comment(s) =>
        var first = true;
        Stacked(s.split('\n').toList.map(s =>
            Raw(s"// $s")
        ))
    }
  }

  def apply(mod: Module) = mkMod(mod).print
  def apply(fh: Function) = mkFun(fh).print
  def apply(instr: Instruction) = mkInstr(instr).print

}
