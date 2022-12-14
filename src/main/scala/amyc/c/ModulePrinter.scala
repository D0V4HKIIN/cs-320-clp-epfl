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
    "#define push stack[stack_pointer++] = ",
    "#define pop stack[--stack_pointer]",
    "#define cnst push ",
    "#define MAX_STACK_SIZE 10000",

    Stacked(mod.imports map mkImport),
    Stacked(mod.functions map mkFun)

  )

  private def mkImport(s: String): Document =
    Lined(List("(import ", s, ")"))

  private def mkFun(fh: Function): Document = {
    val isMain = fh.isMain
    val name = if isMain then "main" else fh.name
    
    // val exportDoc: Document = if (isMain) s"""(export "$name" (func $$$name))""" else ""
    // val paramsDoc: Document = if (fh.args == 0) "" else {
    //   Lined(List(
    //     Lined(fh.params.map(p => {println("int" + p); Raw("int") <:> p}), ", "),
    //   ))
    // }
    val resultDoc: Document = Raw("int")
    // val localsDoc: Document =
    //   if (fh.locals > 0)
    //     "(local " <:> Lined(List.fill(fh.locals)(Raw("i32")), " ") <:> ")"
    //   else
    //     ""

    Stacked(
      Lined(List(resultDoc, s" $$${fh.name}() {")),
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
      case Const(value) => s"i32.const $value"
      case Add => "i32.add"
      case Sub => "i32.sub"
      case Mul => "i32.mul"
      case Div => "i32.div_s"
      case Rem => "i32.rem_s"
      case And => "i32.and"
      case Or  => "i32.or"
      case Eqz => "i32.eqz"
      case Lt_s => "i32.lt_s"
      case Le_s => "i32.le_s"
      case Eq => "i32.eq"
      case Drop => "drop"
      case If_void => "if"
      case If_i32 => "if (result i32)"
      case Else => "else"
      case Block(label) => s"block $$$label"
      case Loop(label) => s"loop $$$label"
      case Br(label)=> s"br $$$label"
      case Return => "ret"
      case End => "end"
      case Call(name) => s"call $$$name"
      case Unreachable => "unreachable"
      case GetLocal(index) => s"local.get $index"
      case SetLocal(index) => s"local.set $index"
      case GetGlobal(index) => s"global.get $index"
      case SetGlobal(index) => s"global.set $index"
      case Store => "i32.store"
      case Load => "i32.load"
      case Store8 => "i32.store8"
      case Load8_u => "i32.load8_u"
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
