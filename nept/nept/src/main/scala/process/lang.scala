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
      case "xml" => Some("XML")
      case "sql" => Some("SQL")
      case _ => None
    }
  }
}
