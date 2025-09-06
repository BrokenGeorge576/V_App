class AddDetailsToManagedFiles < ActiveRecord::Migration[7.2]
  def change
    add_column :managed_files, :favorite, :boolean
    add_column :managed_files, :notes, :text
  end
end
