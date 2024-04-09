object Main {
  def main(args: Array[String]): Unit = {
    if (args.length != 1) {
      println("Usage: scala Main <yaml_file>")
      System.exit(1)
    }
  val xmlFile = args(0)
  val processor = XMLProcessor(xmlFile)
  val elements = processor.process()
  val csvConverter = ArrayListToCSV()

  // Print all elements
  for (i <- 0 until elements.size()) {
    println(elements.get(i))
  }
  csvConverter.convert(elements, "output.csv")
}
}
