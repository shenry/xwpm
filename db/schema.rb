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

ActiveRecord::Schema.define(version: 20150720132800) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachments", force: :cascade do |t|
    t.string   "asset"
    t.integer  "parent_id"
    t.string   "parent_type"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "title",       default: ""
    t.text     "description", default: ""
  end

  add_index "attachments", ["parent_type", "parent_id"], name: "index_attachments_on_parent_type_and_parent_id", using: :btree

  create_table "back_labels", force: :cascade do |t|
    t.integer  "vendor_id"
    t.string   "item_number"
    t.string   "height"
    t.string   "width"
    t.string   "units"
    t.string   "material"
    t.string   "alc"
    t.string   "upc"
    t.string   "rewind"
    t.string   "cut"
    t.string   "position"
    t.string   "treatment"
    t.string   "artwork_source"
    t.string   "image"
    t.string   "artwork"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.boolean  "active",         default: true
  end

  add_index "back_labels", ["vendor_id"], name: "index_back_labels_on_vendor_id", using: :btree

  create_table "bottles", force: :cascade do |t|
    t.string   "item_number"
    t.string   "mould"
    t.string   "shape"
    t.string   "color"
    t.string   "height"
    t.string   "width"
    t.string   "neck_diameter"
    t.string   "units"
    t.string   "finish"
    t.string   "fill_point"
    t.integer  "capacity"
    t.string   "capacity_units"
    t.string   "bottles_per_case"
    t.string   "case_dimensions"
    t.string   "pallet_config"
    t.string   "case_weight"
    t.string   "image"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "active",           default: true
  end

  create_table "capsules", force: :cascade do |t|
    t.string   "item_number"
    t.string   "height"
    t.string   "width"
    t.string   "units"
    t.string   "material"
    t.string   "color"
    t.boolean  "has_artwork", default: false, null: false
    t.string   "image"
    t.string   "artwork"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "active",      default: true
  end

  create_table "closures", force: :cascade do |t|
    t.string   "type"
    t.string   "item_number"
    t.string   "material"
    t.string   "color"
    t.string   "height"
    t.string   "width"
    t.string   "units"
    t.boolean  "has_artwork", default: false, null: false
    t.string   "artwork"
    t.string   "image"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "active",      default: true
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "author_id"
    t.text     "body",        default: "",    null: false
    t.boolean  "actionable",  default: false, null: false
    t.boolean  "resolved",    default: false, null: false
    t.integer  "resolver_id"
    t.datetime "resolved_at"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "comments", ["author_id"], name: "index_comments_on_author_id", using: :btree
  add_index "comments", ["project_id"], name: "index_comments_on_project_id", using: :btree
  add_index "comments", ["resolver_id"], name: "index_comments_on_resolver_id", using: :btree

  create_table "component_requirements", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "packageable_id"
    t.string   "packageable_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "component_requirements", ["packageable_id"], name: "index_component_requirements_on_packageable_id", using: :btree
  add_index "component_requirements", ["packageable_type"], name: "index_component_requirements_on_packageable_type", using: :btree
  add_index "component_requirements", ["project_id"], name: "index_component_requirements_on_project_id", using: :btree

  create_table "components", force: :cascade do |t|
    t.integer  "wine_id"
    t.string   "lot_number"
    t.integer  "volume"
    t.string   "description"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.float    "cogs"
    t.float    "appellation_percent", default: 100.0
    t.float    "vintage_percent",     default: 100.0
    t.float    "variety_percent",     default: 100.0
  end

  add_index "components", ["lot_number"], name: "index_components_on_lot_number", using: :btree
  add_index "components", ["wine_id"], name: "index_components_on_wine_id", using: :btree

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
    t.string   "code"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "front_labels", force: :cascade do |t|
    t.string   "item_number"
    t.string   "height"
    t.string   "width"
    t.string   "units"
    t.string   "material"
    t.string   "alc"
    t.string   "upc"
    t.string   "rewind"
    t.string   "cut"
    t.string   "position"
    t.string   "treatment"
    t.string   "artwork_source"
    t.string   "image"
    t.string   "artwork"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.boolean  "active",         default: true
  end

  create_table "packaging_component_orders", force: :cascade do |t|
    t.integer "component_requirement_id"
    t.integer "purchase_order_id"
    t.float   "quantity",                 default: 0.0
    t.float   "price",                    default: 0.0
    t.boolean "received",                 default: false, null: false
  end

  add_index "packaging_component_orders", ["component_requirement_id"], name: "index_packaging_component_orders_on_component_requirement_id", unique: true, using: :btree
  add_index "packaging_component_orders", ["purchase_order_id"], name: "index_packaging_component_orders_on_purchase_order_id", using: :btree

  create_table "pg_search_documents", force: :cascade do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "pg_search_documents", ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.integer  "wine_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "customer_id"
    t.string   "qb_code"
    t.string   "project_number"
    t.integer  "target_cases"
    t.string   "brand",             default: "",    null: false
    t.string   "description",       default: "",    null: false
    t.datetime "bottling_date"
    t.string   "variety"
    t.string   "winemaker"
    t.boolean  "no_capsule",        default: false, null: false
    t.string   "vintage"
    t.string   "appellation"
    t.string   "closure_type"
    t.string   "trucker"
    t.integer  "cases_to_customer", default: 0,     null: false
    t.integer  "comments_count"
    t.float    "fob"
    t.string   "taxes"
    t.string   "fso2_target"
    t.string   "max_do"
    t.text     "notes",             default: ""
  end

  add_index "projects", ["brand"], name: "index_projects_on_brand", using: :btree
  add_index "projects", ["customer_id"], name: "index_projects_on_customer_id", using: :btree
  add_index "projects", ["project_number"], name: "index_projects_on_project_number", unique: true, using: :btree
  add_index "projects", ["wine_id"], name: "index_projects_on_wine_id", using: :btree

  create_table "purchase_orders", force: :cascade do |t|
    t.integer  "vendor_id"
    t.string   "number",           default: "",  null: false
    t.string   "po_image"
    t.string   "bol_image"
    t.float    "total"
    t.datetime "receive_date"
    t.datetime "order_date"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "line_items_count"
    t.float    "overhead",         default: 0.0
  end

  add_index "purchase_orders", ["vendor_id"], name: "index_purchase_orders_on_vendor_id", using: :btree

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
    t.string   "name",                   default: "",    null: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "vendor_products", force: :cascade do |t|
    t.integer  "vendable_id"
    t.string   "vendable_type"
    t.integer  "vendor_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "vendor_products", ["vendable_id"], name: "index_vendor_products_on_vendable_id", using: :btree
  add_index "vendor_products", ["vendable_type"], name: "index_vendor_products_on_vendable_type", using: :btree
  add_index "vendor_products", ["vendor_id"], name: "index_vendor_products_on_vendor_id", using: :btree

  create_table "wine_shipments", force: :cascade do |t|
    t.integer  "customer_id"
    t.integer  "wine_id"
    t.string   "tracking_number"
    t.datetime "ship_date"
    t.string   "feedback"
    t.string   "carrier"
    t.boolean  "approved",        default: false, null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "wine_shipments", ["customer_id"], name: "index_wine_shipments_on_customer_id", using: :btree
  add_index "wine_shipments", ["tracking_number"], name: "index_wine_shipments_on_tracking_number", using: :btree
  add_index "wine_shipments", ["wine_id"], name: "index_wine_shipments_on_wine_id", using: :btree

  create_table "wines", force: :cascade do |t|
    t.string   "appellation"
    t.string   "variety"
    t.string   "vintage"
    t.string   "alc"
    t.string   "sample_number"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.text     "treatments"
    t.text     "description"
    t.string   "vinx2_reference"
  end

  add_index "wines", ["appellation"], name: "index_wines_on_appellation", using: :btree
  add_index "wines", ["sample_number"], name: "index_wines_on_sample_number", unique: true, using: :btree
  add_index "wines", ["variety"], name: "index_wines_on_variety", using: :btree

end
