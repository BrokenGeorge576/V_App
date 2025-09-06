class CreateFileThemes < ActiveRecord::Migration[7.2]
  def change
    create_table :file_themes do |t|
      t.references :managed_file, null: false, foreign_key: true
      t.references :theme, null: false, foreign_key: true

      t.timestamps
    end
  end
end
