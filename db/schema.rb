# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_01_31_064145) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "conversions", force: :cascade do |t|
    t.date "date"
    t.integer "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["date"], name: "index_conversions_on_date", unique: true
  end

  create_table "domains", force: :cascade do |t|
    t.string "domain_name"
    t.string "short_domain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["domain_name"], name: "index_domains_on_domain_name", unique: true
    t.index ["short_domain"], name: "index_domains_on_short_domain", unique: true
  end

  create_table "urls", force: :cascade do |t|
    t.text "long_url"
    t.string "short_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["long_url"], name: "index_urls_on_long_url", unique: true
    t.index ["short_url"], name: "index_urls_on_short_url", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password"
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
