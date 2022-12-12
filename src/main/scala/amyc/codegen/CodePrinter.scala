package amyc
package codegen

import c.Module
import amyc.utils.{Context, Pipeline, Env}
import scala.sys.process._
import java.io._

// Prints all 4 different files from a wasm Module
object CodePrinter extends Pipeline[Module, Unit]{
  def run(ctx: Context)(m: Module) = {
    val outDirName = "cout"

    def pathWithExt(ext: String) = s"$outDirName/${nameWithExt(ext)}"
    def nameWithExt(ext: String) = s"${m.name}.$ext"

    val (local, inPath) = {
      import Env._
      os match {
        case Linux   => ("./bin/gcc",     "gcc")
        // case Windows => ("./bin/wat2wasm.exe", "wat2wasm.exe")
        // case Mac     => ("./bin/wat2wasm",     "wat2wasm")
      }
    }

    val gccOptions = s"${pathWithExt("c")} -o ${pathWithExt("o")}"

    val outDir = new File(outDirName)
    if (!outDir.exists()) {
      outDir.mkdir()
    }

    m.writeCText(pathWithExt("c"))

    try {
      // first try compiling with local
      try {
        s"$local $gccOptions".!!
      } catch {
        // if exception (file not found) then compile using gcc in path
        case _: IOException =>
          s"$inPath $gccOptions".!!
      }
    } catch {
      case _: IOException =>
        ctx.reporter.fatal(
          "gcc utility was not found under ./bin or in system path, " +
          "or did not have permission to execute. Make sure it is either in the system path, or in <root of the project>/bin"
        )
      case _: RuntimeException =>
        ctx.reporter.fatal(s"gcc failed to translate c text file ${pathWithExt("c")} to binary")
    }

    // not needed for c backend
    // m.writeHtmlWrapper(pathWithExt("html"), nameWithExt("wasm")) // Web version needs path relative to .html
    // m.writeNodejsWrapper(pathWithExt("js"), pathWithExt("wasm")) // Node version needs path relative to project root

  }
}
