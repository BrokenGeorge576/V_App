# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_09_06_051513) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "file_themes", force: :cascade do |t|
    t.bigint "managed_file_id", null: false
    t.bigint "theme_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["managed_file_id"], name: "index_file_themes_on_managed_file_id"
    t.index ["theme_id"], name: "index_file_themes_on_theme_id"
  end

  create_table "managed_files", force: :cascade do |t|
    t.string "name"
    t.string "path"
    t.string "file_type"
    t.integer "size"
    t.datetime "last_modified"
    t.string "ai_topic"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "favorite"
    t.text "notes"
  end

  create_table "themes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "file_themes", "managed_files"
  add_foreign_key "file_themes", "themes"
end
