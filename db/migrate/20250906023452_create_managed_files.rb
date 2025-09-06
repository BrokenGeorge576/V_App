class CreateManagedFiles < ActiveRecord::Migration[7.2]
  def change
    create_table :managed_files do |t|
      t.string :name
      t.string :path
      t.string :file_type
      t.integer :size
      t.datetime :last_modified
      t.string :ai_topic

      t.timestamps
    end
  end
end
