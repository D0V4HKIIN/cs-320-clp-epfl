package amyc

import parsing._
import analyzer.{NameAnalyzer, TypeChecker}
import codegen._
import c.Module
import amyc.utils._
import scala.sys.process._
import scala.collection.JavaConverters._
import java.io.ByteArrayInputStream

class CodegenTests extends ExecutionTests {

  object CodePrinterExecutor extends Pipeline[Module, Unit] {
    def run(ctx: Context)(m: Module) = {
      CodePrinter.run(ctx)(m)
      val fileName = s"${m.name}.c"

      // Consume all standard input!
      val input = Console.in.lines.iterator().asScala.toList.mkString("\n")
      val inputS = new ByteArrayInputStream(input.getBytes("UTF-8"))

      val exitCode = s"./cout/$fileName" #< inputS ! ProcessLogger(Console.out.println, Console.err.println)
      if (exitCode != 0)
        throw AmycFatalError("Nonzero code returned from nodejs. Maybe you forgot to install deasync? (run `npm install deasync` in the root folder of the project, the one that contains the build.sbt), exitcode is " + exitCode)
    }
  }

  val pipeline =
    Lexer andThen
    Parser andThen
    NameAnalyzer andThen
    TypeChecker andThen
    CodeGen andThen
    CodePrinterExecutor
}

