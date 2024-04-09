import java.io.File

class LanguageDetector {
  def detectLanguage(file: File): Option[String] = {
    val extension = file.getName.split('.').lastOption.getOrElse("")
    extension match {
      case "java" => Some("Java")
      case "scala" => Some("Scala")
      case "py" | "python" => Some("Python")
      case "rb" | "ruby" => Some("Ruby")
      case "js" | "javascript" => Some("JavaScript")
      case "cpp" | "c" | "h" | "hpp" => Some("C/C++")
      case "html" | "htm" => Some("HTML")
      case "css" => Some("CSS")
      case "xml" => Some("XML")
      case "json" => Some("JSON")
      case "sql" => Some("SQL")
      case _ => None
    }
  }
}
