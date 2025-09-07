namespace :files do
  desc "Escanea un directorio y guarda la información en la base de datos"

  task scan_and_save: :environment do
    target_directory = 'C:/Users/cr7-r/OneDrive/Documentos/Memoria vieja' 

    puts "=================================================="
    puts "Iniciando escaneo y guardado en: #{target_directory}"
    puts "Se imprimirá un '.' por cada archivo procesado."
    puts "=================================================="

    Dir.glob(File.join(target_directory, '**', '*')) do |file_path|
      next unless File.file?(file_path)

      ManagedFile.find_or_create_by!(path: file_path) do |managed_file|
        managed_file.name = File.basename(file_path, ".*") #Obtiene el nombre sin el tipo
        managed_file.file_type = File.extname(file_path).delete('.') #Obtiene la extension del archivo
        managed_file.size = File.size(file_path) #Obtiene el tama;o del archivo
        managed_file.last_modified = File.mtime(file_path) #Obtiene ultima fecha de modificacion 
      end

      print '.'
    end

    puts "\n=================================================="
    puts "¡Proceso finalizado! Los archivos han sido guardados en la base de datos."
    puts "=================================================="
  end
end
