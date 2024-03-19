# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150714074319) do

  create_table "galleries", force: :cascade do |t|
    t.string   "gallery_name"
    t.text     "gallery_description"
    t.string   "flickr_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "wedding_id"
  end

  create_table "gifts", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "wedding_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "can_be_given_multiple"
    t.string   "multiple_users"
  end

  add_index "gifts", ["user_id"], name: "index_gifts_on_user_id"
  add_index "gifts", ["wedding_id"], name: "index_gifts_on_wedding_id"

  create_table "invitation_texts", force: :cascade do |t|
    t.integer  "wedding_id"
    t.integer  "language_id"
    t.text     "back_body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "front_body"
    t.text     "single_front_body"
    t.text     "single_back_body"
  end

  add_index "invitation_texts", ["language_id"], name: "index_invitation_texts_on_language_id"
  add_index "invitation_texts", ["wedding_id"], name: "index_invitation_texts_on_wedding_id"

  create_table "languages", force: :cascade do |t|
    t.string   "tag"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "languages_weddings", force: :cascade do |t|
    t.integer "language_id"
    t.integer "wedding_id"
  end

  add_index "languages_weddings", ["language_id"], name: "index_languages_weddings_on_language_id"
  add_index "languages_weddings", ["wedding_id"], name: "index_languages_weddings_on_wedding_id"

  create_table "pages", force: :cascade do |t|
    t.string   "page_title"
    t.text     "page_body"
    t.integer  "wedding_id"
    t.integer  "language_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sort_order"
    t.string   "imageurl"
  end

  add_index "pages", ["language_id"], name: "index_pages_on_language_id"
  add_index "pages", ["wedding_id"], name: "index_pages_on_wedding_id"

  create_table "qandas", force: :cascade do |t|
    t.text     "body"
    t.integer  "parent_id"
    t.integer  "wedding_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "qandas", ["user_id"], name: "index_qandas_on_user_id"
  add_index "qandas", ["wedding_id"], name: "index_qandas_on_wedding_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "language_id"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "role"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
    t.string   "token"
    t.string   "token_secret"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count"
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "wedding_descriptions", force: :cascade do |t|
    t.text     "body"
    t.integer  "wedding_id"
    t.integer  "language_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "wedding_descriptions", ["language_id"], name: "index_wedding_descriptions_on_language_id"
  add_index "wedding_descriptions", ["wedding_id"], name: "index_wedding_descriptions_on_wedding_id"

  create_table "wedding_guests", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "wedding_id"
    t.boolean  "accepted",    default: false
    t.string   "url",         default: ""
    t.string   "short_token", default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wedding_guests", ["user_id"], name: "index_wedding_guests_on_user_id"
  add_index "wedding_guests", ["wedding_id"], name: "index_wedding_guests_on_wedding_id"

  create_table "weddings", force: :cascade do |t|
    t.string   "title"
    t.datetime "wedding_date"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.string   "playlist_id"
    t.string   "spotify_name"
    t.text     "spotify_hash"
  end

  add_index "weddings", ["user_id"], name: "index_weddings_on_user_id"

end
