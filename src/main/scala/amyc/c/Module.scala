package amyc
package c

// A WebAssembly module
case class Module(name: String, imports: List[String], globals: Int, functions: List[Function]) {

  import java.io.{File, FileWriter}

  def writeCText(fileName: String) = {
    val fw = new FileWriter(new File(fileName))
    fw.write(ModulePrinter(this))
    fw.flush()
  }
}
