import scala.xml._
import java.util.ArrayList

class XMLProcessor(xmlFile: String) {
  def process(): ArrayList[String] = {
    // Load the XML file
    val xml = XML.loadFile(xmlFile)
    
    // Create an ArrayList to store XML elements
    val elements = new ArrayList[String]()

    // Extract all elements from the XML
    val allNodes = xml.descendant
    allNodes.foreach { node =>
      elements.add(node.toString)
    }
    
    // Return the ArrayList of XML elements
    elements
  }
}

object XMLProcessor {
  def apply(xmlFile: String): XMLProcessor = new XMLProcessor(xmlFile)
}

