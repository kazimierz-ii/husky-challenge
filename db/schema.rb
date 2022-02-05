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

ActiveRecord::Schema.define(version: 2022_02_05_201134) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_tokens", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "token"
    t.string "status", limit: 1
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "approved_at", precision: 6
    t.datetime "revoked_at", precision: 6
    t.datetime "last_access_at", precision: 6
    t.index ["status"], name: "index_access_tokens_on_status"
    t.index ["user_id"], name: "index_access_tokens_on_user_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.string "invoice_number"
    t.date "invoice_date"
    t.float "total_amount_due"
    t.string "emails"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "invoice_from"
    t.text "invoice_to"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "access_tokens", "users"
end
