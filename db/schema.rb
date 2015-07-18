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

ActiveRecord::Schema.define(version: 1) do

  create_table "agencies", force: :cascade do |t|
    t.string "login_name",        limit: 30,  default: "", null: false
    t.string "login_password",    limit: 255, default: "", null: false
    t.string "name",              limit: 255, default: "", null: false
    t.string "address",           limit: 255, default: "", null: false
    t.string "contact",           limit: 255, default: "", null: false
    t.string "phone",             limit: 255, default: "", null: false
    t.string "profile",           limit: 255, default: "", null: false
    t.string "persistence_token", limit: 255,              null: false
  end

  create_table "buy_car_requests", force: :cascade do |t|
    t.integer  "user_id",        limit: 4,                null: false
    t.string   "user_id_number", limit: 255, default: "", null: false
    t.integer  "agency_id",      limit: 4,                null: false
    t.string   "req_info",       limit: 255, default: "", null: false
    t.string   "money_io_ids",   limit: 255, default: "", null: false
    t.datetime "create_time",                             null: false
    t.integer  "status",         limit: 4,   default: 0,  null: false
  end

  create_table "code_sources", force: :cascade do |t|
    t.integer  "user_id",        limit: 4,                                          null: false
    t.string   "code",           limit: 255,                          default: "0", null: false
    t.integer  "add_point",      limit: 4,                            default: 0,   null: false
    t.decimal  "add_money",                  precision: 12, scale: 2, default: 0.0, null: false
    t.integer  "from_agency_id", limit: 4,                                          null: false
    t.string   "remarks",        limit: 200
    t.datetime "create_time",                                                       null: false
    t.datetime "expire_time",                                                       null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "order_id",    limit: 4, default: 0, null: false
    t.integer "product_id",  limit: 4, default: 0, null: false
    t.integer "pre_point",   limit: 4, default: 0, null: false
    t.integer "count",       limit: 4, default: 0, null: false
    t.integer "total_point", limit: 4, default: 0, null: false
  end

  create_table "order_shippings", force: :cascade do |t|
    t.integer "order_id",  limit: 4,   default: 0,  null: false
    t.string  "real_name", limit: 255, default: "", null: false
    t.string  "mobile",    limit: 255, default: "", null: false
    t.string  "country",   limit: 255,              null: false
    t.string  "province",  limit: 255,              null: false
    t.string  "city",      limit: 255,              null: false
    t.string  "area",      limit: 255,              null: false
    t.string  "post_code", limit: 255,              null: false
    t.string  "address",   limit: 255,              null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id",     limit: 4,   default: 0, null: false
    t.integer  "order_point", limit: 4,   default: 0, null: false
    t.integer  "status",      limit: 4,   default: 0, null: false
    t.datetime "create_time",                         null: false
    t.string   "remarks",     limit: 200
  end

  create_table "products", force: :cascade do |t|
    t.string   "name",            limit: 255,              null: false
    t.integer  "sales_point",     limit: 4,                null: false
    t.integer  "original_point",  limit: 4,   default: 0,  null: false
    t.string   "product_img_url", limit: 60,  default: "", null: false
    t.integer  "inventory",       limit: 4,   default: 0,  null: false
    t.string   "description",     limit: 255
    t.datetime "create_time",                              null: false
  end

  create_table "user_addresses", force: :cascade do |t|
    t.integer "user_id",   limit: 4,                null: false
    t.string  "real_name", limit: 255, default: "", null: false
    t.string  "mobile",    limit: 255, default: "", null: false
    t.string  "country",   limit: 255,              null: false
    t.string  "province",  limit: 255,              null: false
    t.string  "city",      limit: 255,              null: false
    t.string  "area",      limit: 255,              null: false
    t.string  "post_code", limit: 255,              null: false
    t.string  "address",   limit: 255,              null: false
  end

  create_table "user_infos", force: :cascade do |t|
    t.string   "login_name",        limit: 30,                           default: "",  null: false
    t.string   "login_password",    limit: 255,                          default: "",  null: false
    t.string   "real_name",         limit: 255,                          default: "",  null: false
    t.integer  "sex",               limit: 2,                            default: 0,   null: false
    t.datetime "create_time",                                                          null: false
    t.integer  "user_point",        limit: 4,                            default: 0,   null: false
    t.decimal  "user_money",                    precision: 12, scale: 2, default: 0.0, null: false
    t.string   "profile",           limit: 255,                          default: "",  null: false
    t.string   "persistence_token", limit: 255,                                        null: false
  end

  create_table "user_money_ios", force: :cascade do |t|
    t.integer  "user_id",        limit: 4,                                         null: false
    t.decimal  "money",                      precision: 12, scale: 2,              null: false
    t.string   "remarks",        limit: 125,                                       null: false
    t.integer  "status",         limit: 4,                            default: 0,  null: false
    t.datetime "operate_time",                                                     null: false
    t.string   "code",           limit: 255,                          default: "", null: false
    t.integer  "from_agency_id", limit: 4,                                         null: false
  end

  create_table "user_point_ios", force: :cascade do |t|
    t.integer  "user_id",      limit: 4,                null: false
    t.integer  "point",        limit: 4,   default: 0,  null: false
    t.string   "remarks",      limit: 125,              null: false
    t.integer  "status",       limit: 4,   default: 0,  null: false
    t.datetime "operate_time",                          null: false
    t.string   "from",         limit: 255, default: "", null: false
    t.string   "code",         limit: 255, default: "", null: false
  end

end
