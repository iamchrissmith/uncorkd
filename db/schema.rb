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

ActiveRecord::Schema.define(version: 20170916222940) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_trgm"

  create_table "badges", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "follows", force: :cascade do |t|
    t.bigint "user_id"
    t.string "target_type"
    t.bigint "target_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["target_type", "target_id"], name: "index_follows_on_target_type_and_target_id"
    t.index ["user_id"], name: "index_follows_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.text "description"
    t.integer "rating"
    t.bigint "user_id"
    t.string "reviewable_type"
    t.bigint "reviewable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reviewable_type", "reviewable_id"], name: "index_reviews_on_reviewable_type_and_reviewable_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "user_badges", force: :cascade do |t|
    t.bigint "badge_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["badge_id"], name: "index_user_badges_on_badge_id"
    t.index ["user_id"], name: "index_user_badges_on_user_id"
  end

  create_table "user_venues", force: :cascade do |t|
    t.bigint "venue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "manager_id"
    t.string "manager_type"
    t.index ["venue_id"], name: "index_user_venues_on_venue_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.string "email"
    t.text "bio"
    t.string "phone_number"
    t.string "password_digest"
    t.integer "role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "country_code"
    t.boolean "verified", default: false
    t.integer "authy_id"
    t.bigint "uid"
    t.integer "status", default: 0
  end

  create_table "venue_wines", force: :cascade do |t|
    t.bigint "venue_id"
    t.bigint "wine_id"
    t.index ["venue_id"], name: "index_venue_wines_on_venue_id"
    t.index ["wine_id"], name: "index_venue_wines_on_wine_id"
  end

  create_table "venues", force: :cascade do |t|
    t.string "name"
    t.string "street_address"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
  end

  create_table "wines", force: :cascade do |t|
    t.string "name"
    t.string "varietal"
    t.string "vintage"
    t.string "vineyard"
    t.integer "rating"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_wines_on_name"
  end

  add_foreign_key "follows", "users"
  add_foreign_key "reviews", "users"
  add_foreign_key "user_badges", "badges"
  add_foreign_key "user_badges", "users"
  add_foreign_key "user_venues", "venues"
  add_foreign_key "venue_wines", "venues"
  add_foreign_key "venue_wines", "wines"
end
