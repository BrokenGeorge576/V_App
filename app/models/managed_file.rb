#Cada registro en esta tabla representará un archivo de tu computadora.
# name: Nombre del archivo.
# path: Direccion del archivo.
# file_type: Para saber si es un "pdf", "txt", "jpg", etc.
# size: Tamano.
# last_modified:Ultima modificacion.
# ai_topic: Tema generado por la IA.
class ManagedFile < ApplicationRecord
  has_many :file_themes, dependent: :destroy
  has_many :themes, through: :file_themes
end
