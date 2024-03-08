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

ActiveRecord::Schema[7.1].define(version: 2024_03_08_015440) do
  create_table "activities", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "image"
    t.string "title", null: false
    t.date "date", default: "2024-03-06", null: false
    t.time "time", default: "2000-01-01 01:22:28", null: false
    t.string "speaker_name"
    t.string "speaker_surname"
    t.string "speaker_job"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "activity_types", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "activity_id"
    t.index ["activity_id"], name: "index_activity_types_on_activity_id"
  end

  create_table "app_auths", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
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

  create_table "tickets", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "code"
    t.boolean "validated", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "type_ticket_id", null: false
    t.index ["code"], name: "index_tickets_on_code", unique: true
    t.index ["type_ticket_id"], name: "index_tickets_on_type_ticket_id"
  end

  create_table "type_tickets", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.float "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", null: false
    t.string "encrypted_password", null: false
    t.string "full_name", null: false
    t.integer "role", default: 0, null: false
    t.string "phone", null: false
    t.string "university"
    t.datetime "birth_date"
    t.string "gender"
    t.string "badge_name"
    t.string "nationality"
    t.string "rg"
    t.string "cpf"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "provider"
    t.string "uid"
    t.string "avatar_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["rg", "cpf"], name: "index_users_on_rg_and_cpf", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "activity_types", "activities"
  add_foreign_key "tickets", "type_tickets"
end
