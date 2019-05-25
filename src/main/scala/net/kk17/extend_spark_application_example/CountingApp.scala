package net.kk17.extend_spark_application_example

import org.apache.spark.sql.SparkSession
import org.apache.spark.SparkConf
import play.api.libs.json.Json

/**
  * Use this to test the app locally, from sbt:
  * sbt "run inputFile.txt outputFile.txt"
  *  (+ select CountingLocalApp when prompted)
  */
object CountingLocalApp extends App{
  val (inputFile, outputFile) = (args(0), args(1))
  val conf = new SparkConf()
    .setMaster("local")
    .setAppName("my awesome app")

  Runner.run(conf, inputFile, outputFile)
}

object CountingLocalAppSetJars extends App{
  val (inputFile, outputFile) = (args(0), args(1))
  var homeDir = "/workspace"
  if (args.length > 2) {
    homeDir = args(2)
  }
  val conf = new SparkConf()
    .setMaster("local")
    .set("spark.jars", s"${homeDir}/lib_managed/jars/com.typesafe.play/play-json_2.11/play-json_2.11-2.6.9.jar," +
      s"${homeDir}/lib_managed/jars/com.typesafe.play/play-functional_2.11/play-functional_2.11-2.6.9.jar")

  Runner.run(conf, inputFile, outputFile)
}

object CountingLocalAppSetJars2 extends App{
  val (inputFile, outputFile) = (args(0), args(1))
  var homeDir = "/workspace"
  if (args.length > 2) {
    homeDir = args(2)
  }
  val conf = new SparkConf()
    .setMaster("local")
    .setJars(Seq(
      s"${homeDir}/lib_managed/jars/com.typesafe.play/play-json_2.11/play-json_2.11-2.6.9.jar",
      s"${homeDir}/lib_managed/jars/com.typesafe.play/play-functional_2.11/play-functional_2.11-2.6.9.jar"))

  Runner.run(conf, inputFile, outputFile)
}


/**
  * Use this when submitting the app to a cluster with spark-submit
  * */
object CountingApp extends App{
  val (inputFile, outputFile) = (args(0), args(1))

  // spark-submit command should supply all necessary config elements
  Runner.run(new SparkConf(), inputFile, outputFile)
}

object Runner {
  def run(conf: SparkConf, inputFile: String, outputFile: String): Unit = {
    val spark = new SparkSession.Builder().config(conf).getOrCreate()
    val rdd = spark.sparkContext.textFile(inputFile)
    val counts = WordCount.withStopWordsFiltered(rdd)
//    counts.saveAsTextFile(outputFile) //FileAlreadyExistsException may throwed here
    val wordCount = counts.collectAsMap()
    println("-" * 80)
    println(Json.prettyPrint(Json.toJson(wordCount)))
    println("-" * 80)
  }
}
