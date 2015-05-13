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

ActiveRecord::Schema.define(version: 20150513210430) do

  create_table "firms", force: :cascade do |t|
    t.string   "type"
    t.string   "name",           default: "", null: false
    t.string   "description",    default: "", null: false
    t.string   "contact_name"
    t.string   "contact_email"
    t.string   "contact_phone"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "bond"
    t.string   "account_number"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "projects_count"
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
    t.string   "name",           default: "", null: false
    t.string   "description",    default: "", null: false
    t.integer  "closure_id"
    t.integer  "bottle_id"
    t.integer  "front_label_id"
    t.integer  "back_label_id"
    t.integer  "capsule_id"
    t.integer  "shipper_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "packages", ["back_label_id"], name: "index_packages_on_back_label_id"
  add_index "packages", ["bottle_id"], name: "index_packages_on_bottle_id"
  add_index "packages", ["capsule_id"], name: "index_packages_on_capsule_id"
  add_index "packages", ["closure_id"], name: "index_packages_on_closure_id"
  add_index "packages", ["front_label_id"], name: "index_packages_on_front_label_id"
  add_index "packages", ["shipper_id"], name: "index_packages_on_shipper_id"

  create_table "packaging_components", force: :cascade do |t|
    t.string   "type"
    t.string   "name",             default: "",    null: false
    t.string   "description",      default: "",    null: false
    t.integer  "vendor_id"
    t.string   "mould"
    t.string   "shape"
    t.string   "color"
    t.string   "height"
    t.string   "width"
    t.string   "depth"
    t.string   "fill_point"
    t.string   "fill_point_units"
    t.string   "material"
    t.boolean  "has_artwork",      default: false
    t.string   "capacity"
    t.string   "capacity_units"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "label_alc"
    t.string   "upc"
    t.string   "closure_type"
    t.string   "artwork_source"
    t.string   "label_type"
    t.string   "units"
    t.string   "label_rewind"
    t.string   "label_treatment"
    t.string   "label_cut"
    t.string   "label_position"
  end

  add_index "packaging_components", ["closure_type"], name: "index_packaging_components_on_closure_type"
  add_index "packaging_components", ["label_type"], name: "index_packaging_components_on_label_type"
  add_index "packaging_components", ["type"], name: "index_packaging_components_on_type"
  add_index "packaging_components", ["vendor_id"], name: "index_packaging_components_on_vendor_id"

  create_table "projects", force: :cascade do |t|
    t.integer  "package_id"
    t.integer  "wine_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "customer_id"
    t.string   "qb_code"
    t.string   "project_number"
    t.integer  "target_cases"
    t.string   "brand",          default: "", null: false
    t.string   "description",    default: "", null: false
    t.datetime "bottling_date"
  end

  add_index "projects", ["customer_id"], name: "index_projects_on_customer_id"
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

  create_table "wines", force: :cascade do |t|
    t.string   "name",                default: "", null: false
    t.string   "description",         default: "", null: false
    t.string   "appellation"
    t.string   "appellation_percent"
    t.string   "variety"
    t.string   "variety_percent"
    t.string   "vintage"
    t.string   "vintage_percent"
    t.string   "alc"
    t.string   "winemaker"
    t.string   "sample_number"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

end
