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

ActiveRecord::Schema[7.0].define(version: 2024_04_09_024800) do
  create_table "activities", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.string "duration", null: false
    t.string "image"
    t.date "date", null: false
    t.string "workload", null: false
    t.time "start_time", null: false
    t.string "location", null: false
    t.integer "capacity", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "activity_type_id"
    t.index ["activity_type_id"], name: "index_activities_on_activity_type_id"
  end

  create_table "activities_guests", id: false, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "activity_id"
    t.bigint "guest_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_activities_guests_on_activity_id"
    t.index ["guest_id"], name: "index_activities_guests_on_guest_id"
  end

  create_table "activities_users", id: false, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "activity_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_activities_users_on_activity_id"
    t.index ["user_id"], name: "index_activities_users_on_user_id"
  end

  create_table "activity_types", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "events", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.string "link"
    t.integer "status"
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.string "cep"
    t.string "street"
    t.string "city"
    t.string "neighborhood"
    t.string "link_google_maps"
    t.boolean "publico", default: false
    t.date "start_date_sale_ticket"
    t.date "end_date_sale_ticket"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "guests", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "full_name", null: false
    t.string "email", null: false
    t.text "description", null: false
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "response"
    t.string "x_idempotency_key"
    t.integer "tipo"
    t.integer "status", default: 0
    t.bigint "user_id"
    t.bigint "type_ticket_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type_ticket_id"], name: "index_payments_on_type_ticket_id"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "tickets", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "code"
    t.boolean "validated", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "type_ticket_id", null: false
    t.bigint "user_id", null: false
    t.index ["code"], name: "index_tickets_on_code", unique: true
    t.index ["type_ticket_id"], name: "index_tickets_on_type_ticket_id"
    t.index ["user_id"], name: "index_tickets_on_user_id"
  end

  create_table "type_tickets", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.float "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "event_id", null: false
    t.index ["event_id"], name: "index_type_tickets_on_event_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "full_name"
    t.string "email", null: false
    t.integer "role", default: 0, null: false
    t.string "phone", null: false
    t.string "university"
    t.date "birth_date"
    t.integer "gender"
    t.string "nationality"
    t.string "rg"
    t.string "cpf"
    t.string "address"
    t.boolean "validate_account_update_params", default: false
    t.text "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "activities", "activity_types"
  add_foreign_key "tickets", "type_tickets"
  add_foreign_key "tickets", "users"
  add_foreign_key "type_tickets", "events"
end
