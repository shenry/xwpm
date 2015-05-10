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

ActiveRecord::Schema.define(version: 20150510051819) do

  create_table "businesses", force: :cascade do |t|
    t.string   "name"
    t.string   "contact_name"
    t.string   "contact_phone"
    t.string   "contact_email"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "bond"
    t.string   "account_number"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "type"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "packages", force: :cascade do |t|
    t.string   "name"
    t.string   "upc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "packages_packaging_tables", id: false, force: :cascade do |t|
    t.integer "package_id"
    t.integer "packaging_table_id",     null: false
    t.integer "packaging_component_id"
  end

  add_index "packages_packaging_tables", ["package_id"], name: "index_packages_packaging_tables_on_package_id"
  add_index "packages_packaging_tables", ["packaging_component_id"], name: "index_packages_packaging_tables_on_packaging_component_id"

  create_table "packaging_components", force: :cascade do |t|
    t.string   "type"
    t.string   "color"
    t.string   "art_source"
    t.string   "height"
    t.string   "height_units"
    t.string   "width"
    t.string   "width_units"
    t.string   "depth"
    t.string   "depth_units"
    t.string   "weight"
    t.string   "weight_units"
    t.string   "treatment"
    t.string   "die_cut"
    t.string   "label_alc"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "mould"
    t.string   "shape"
    t.integer  "business_id"
  end

  create_table "projects", force: :cascade do |t|
    t.integer  "package_id"
    t.datetime "bottling_date"
    t.integer  "cases"
    t.string   "approved_sample"
    t.integer  "wine_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "customer_id"
    t.integer  "bottler_id"
    t.integer  "bottling_facility_id"
  end

  add_index "projects", ["package_id"], name: "index_projects_on_package_id"
  add_index "projects", ["wine_id"], name: "index_projects_on_wine_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.boolean  "admin",                  default: false, null: false
    t.boolean  "locked",                 default: false, null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
