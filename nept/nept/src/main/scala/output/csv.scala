import java.io.PrintWriter
import java.util.ArrayList

class ArrayListToCSV {

  def convert(arrayList: ArrayList[String], csvFilePath: String): Unit = {
    val writer = new PrintWriter(csvFilePath)
    try {
      writer.println(arrayList.toArray.mkString(","))
    } finally {
      writer.close()
    }
  }
}

