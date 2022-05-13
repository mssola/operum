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

ActiveRecord::Schema[7.0].define(version: 2022_07_08_090103) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "annotations", force: :cascade do |t|
    t.bigint "thing_id", null: false
    t.string "note"
    t.string "marker"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["thing_id"], name: "index_annotations_on_thing_id"
  end

  create_table "group_things", force: :cascade do |t|
    t.bigint "group_id", null: false
    t.bigint "thing_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id", "thing_id"], name: "index_group_things_on_group_id_and_thing_id", unique: true
    t.index ["group_id"], name: "index_group_things_on_group_id"
    t.index ["thing_id"], name: "index_group_things_on_thing_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "user_id"], name: "index_groups_on_name_and_user_id", unique: true
    t.index ["user_id"], name: "index_groups_on_user_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_languages_on_code", unique: true
  end

  create_table "people", force: :cascade do |t|
    t.string "full_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["full_name"], name: "index_people_on_full_name", unique: true
  end

  create_table "thing_languages", force: :cascade do |t|
    t.bigint "thing_id", null: false
    t.bigint "language_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["language_id"], name: "index_thing_languages_on_language_id"
    t.index ["thing_id"], name: "index_thing_languages_on_thing_id"
  end

  create_table "thing_people", force: :cascade do |t|
    t.bigint "thing_id", null: false
    t.bigint "person_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0
    t.index ["person_id"], name: "index_thing_people_on_person_id"
    t.index ["thing_id"], name: "index_thing_people_on_thing_id"
  end

  create_table "things", force: :cascade do |t|
    t.string "target", null: false
    t.string "title", null: false
    t.string "publisher"
    t.string "address"
    t.integer "year"
    t.string "url"
    t.datetime "access"
    t.string "location"
    t.string "insideof"
    t.string "pages"
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.integer "rate", default: 0
    t.integer "status", default: 0
    t.integer "kind", default: 0
    t.datetime "bought_at"
    t.index ["target"], name: "index_things_on_target", unique: true
    t.index ["title"], name: "index_things_on_title", unique: true
    t.index ["user_id"], name: "index_things_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "annotations", "things"
  add_foreign_key "group_things", "groups"
  add_foreign_key "group_things", "things"
  add_foreign_key "groups", "users"
  add_foreign_key "thing_languages", "languages"
  add_foreign_key "thing_languages", "things"
  add_foreign_key "thing_people", "people"
  add_foreign_key "thing_people", "things"
  add_foreign_key "things", "users"
end
