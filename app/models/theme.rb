class Theme < ApplicationRecord
  has_many :file_themes, dependent: :destroy
  has_many :managed_files, through: :file_themes
end
