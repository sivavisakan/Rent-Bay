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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111206190756) do

  create_table "bids", :force => true do |t|
    t.integer  "userid"
    t.integer  "itemid"
    t.float    "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "amount"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.string   "Name"
    t.string   "Category"
    t.text     "Rental_Period"
    t.string   "Upload_Picture"
    t.text     "Description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sellerid"
    t.string   "expiry"
    t.float    "buyitnowprice"
    t.boolean  "sold"
    t.integer  "forsale"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "expirynew"
    t.string   "terms"
    t.string   "address"
    t.string   "city"
    t.string   "country"
    t.string   "zip"
    t.string   "lat"
    t.string   "lon"
    t.string   "url"
    t.float    "Price"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "usertype"
    t.string   "encrypted_password"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "salt"
    t.string   "dob"
    t.string   "lastname"
    t.string   "country"
    t.string   "zip"
    t.string   "city"
    t.string   "phone"
    t.string   "notification"
    t.integer  "active"
    t.integer  "visit"
  end

end
