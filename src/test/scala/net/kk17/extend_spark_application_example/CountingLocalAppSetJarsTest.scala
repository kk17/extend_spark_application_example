package net.kk17.extend_spark_application_example

import org.scalatest.FunSuite

class CountingLocalAppSetJarsTest extends FunSuite {
  test("run") {
    val homeDir = "."
    CountingLocalAppSetJars.main(Array(s"${homeDir}/README.md", "/tmp/output", homeDir))
  }
}
