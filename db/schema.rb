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

ActiveRecord::Schema.define(version: 20150511043120) do

  create_table "closures", force: :cascade do |t|
    t.string   "type"
    t.integer  "vendor_id"
    t.string   "name",           default: "",    null: false
    t.string   "description",    default: "",    null: false
    t.string   "color"
    t.boolean  "has_artwork",    default: false
    t.string   "material"
    t.string   "height"
    t.string   "height_units"
    t.string   "diameter"
    t.string   "diameter_units"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "closures", ["type"], name: "index_closures_on_type"
  add_index "closures", ["vendor_id"], name: "index_closures_on_vendor_id"

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

  create_table "labels", force: :cascade do |t|
    t.integer  "vendor_id"
    t.string   "name",         default: "", null: false
    t.string   "description",  default: "", null: false
    t.string   "art_source"
    t.string   "width"
    t.string   "width_units"
    t.string   "length"
    t.string   "length_units"
    t.string   "material"
    t.string   "treatment"
    t.string   "die_cut"
    t.string   "upc"
    t.string   "label_alc"
    t.string   "type"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "labels", ["vendor_id"], name: "index_labels_on_vendor_id"

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

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.integer  "package_id"
    t.integer  "wine_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
