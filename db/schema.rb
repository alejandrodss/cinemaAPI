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

ActiveRecord::Schema.define(version: 2019_07_24_011423) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "days", force: :cascade do |t|
    t.string "name"
    t.string "code", null: false
    t.index ["code"], name: "index_days_on_code", unique: true
  end

  create_table "movie_days", force: :cascade do |t|
    t.bigint "day_id"
    t.bigint "movie_id"
    t.index ["day_id"], name: "index_movie_days_on_day_id"
    t.index ["movie_id"], name: "index_movie_days_on_movie_id"
  end

  create_table "movies", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "image_url"
  end

  create_table "reservations", force: :cascade do |t|
    t.bigint "movie_id"
    t.bigint "day_id"
    t.integer "identification_number"
    t.string "name"
    t.string "email"
    t.integer "phone"
    t.index ["day_id"], name: "index_reservations_on_day_id"
    t.index ["movie_id"], name: "index_reservations_on_movie_id"
  end

  add_foreign_key "reservations", "days"
  add_foreign_key "reservations", "movies"
end
