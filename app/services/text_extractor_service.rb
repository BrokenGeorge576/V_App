require 'pdf/reader'
class TextExtractorService
  def initialize(managed_file)
    @managed_file = managed_file
    @path = managed_file.path
  end

  def call
    return "Error: El archivo no se encontró en la ruta #{@path}" unless File.exist?(@path)

    case @managed_file.file_type
    when 'pdf'
      extract_from_pdf
    when 'txt', 'md', 'rb', 'slim', 'js', 'scss', 'css', 'html', 'yml','py'
      extract_from_text_file
    else
      "Lo sentimos, el chatbot aún no es compatible con archivos de tipo '#{@managed_file.file_type}'."
    end
  rescue => e
    "Error al procesar el archivo: #{e.message}"
  end

  private

  def extract_from_pdf
    reader = PDF::Reader.new(@path)
    reader.pages.map(&:text).join("\n\n")
  end

  def extract_from_text_file
    File.read(@path)
  end
end