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

ActiveRecord::Schema[7.1].define(version: 2024_03_04_005249) do
  create_table "app_auths", id: :string, default: -> { "uuid()" }, charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "employee_name"
    t.integer "celula"
    t.string "code", null: false
    t.string "key_digest"
    t.timestamp "last_created_key_at"
    t.boolean "ativo", default: false
    t.timestamp "activation_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tickets", id: :string, default: -> { "uuid()" }, charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "code"
    t.boolean "validated", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "type_ticket_id", null: false
    t.index ["code"], name: "index_tickets_on_code", unique: true
    t.index ["type_ticket_id"], name: "index_tickets_on_type_ticket_id"
  end

  create_table "type_tickets", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.float "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "tickets", "type_tickets"
end
