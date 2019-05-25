package net.kk17.extend_spark_application_example

import org.scalatest.FunSuite

class CountingLocalAppSetJars2Test extends FunSuite {
  test("run") {
    val homeDir = "."
    CountingLocalAppSetJars2.main(Array(s"${homeDir}/README.md", "/tmp/output", homeDir))
  }
}
