# Conecta un archivo con un tema
# managed_file_id: id del archivo
# theme_id: id de la categoria
class FileTheme < ApplicationRecord
  belongs_to :managed_file
  belongs_to :theme
end
