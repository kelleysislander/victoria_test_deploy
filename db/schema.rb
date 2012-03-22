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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120316165452) do

  create_table "accounts", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "address"
    t.string   "city"
    t.string   "state",         :limit => 2
    t.string   "zip"
    t.string   "phone",         :limit => 45
    t.string   "contact_name"
    t.string   "contact_email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "advertisement_types", :force => true do |t|
    t.string   "advertisement_type"
    t.string   "description",        :limit => 512
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "advertisements", :force => true do |t|
    t.integer  "retailer_id"
    t.integer  "advertiser_id"
    t.integer  "advertisement_type_id"
    t.string   "name"
    t.string   "description"
    t.text     "content"
    t.date     "beg_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.string   "url"
    t.integer  "retailer_zone"
  end

  create_table "advertiser_types", :force => true do |t|
    t.string   "advertiser_type"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "advertisers", :force => true do |t|
    t.integer  "advertiser_type_id",               :null => false
    t.integer  "retailer_id"
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state",              :limit => 2
    t.string   "zip",                :limit => 45
    t.string   "phone"
    t.string   "contact_name"
    t.string   "contact_email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.string   "secret"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "compass_points", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deal_types", :force => true do |t|
    t.string   "deal_type"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deals", :force => true do |t|
    t.integer  "deal_type_id"
    t.integer  "retailer_id",                                               :null => false
    t.integer  "advertiser_id"
    t.string   "name",                                                      :null => false
    t.string   "description",              :limit => 3000,                  :null => false
    t.text     "content"
    t.integer  "featured_flag"
    t.integer  "num_offered"
    t.integer  "num_available"
    t.integer  "num_redeemed",                             :default => 0
    t.date     "beg_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "badge_text"
    t.string   "badge_path"
    t.string   "image"
    t.string   "discount_percent_text"
    t.string   "discount_amount_text"
    t.string   "price_text"
    t.string   "fine_print_text"
    t.string   "deal_tag_text"
    t.integer  "preview_flag",                             :default => 1
    t.integer  "skeleton_flag",                            :default => 1
    t.string   "gender",                   :limit => 1,    :default => "B"
    t.integer  "active_flag",                              :default => 0
    t.float    "retailer_latitude"
    t.float    "retailer_longitude"
    t.string   "featured_image"
    t.string   "share_to_unlock_pct"
    t.integer  "retailer_zone"
    t.integer  "social_discount_interval"
    t.string   "redemption_passphrase"
  end

  create_table "device_redemptions", :force => true do |t|
    t.string   "device_uid"
    t.integer  "deal_id"
    t.string   "redemption_type"
    t.date     "redemption_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "maps", :force => true do |t|
    t.string "description", :limit => 45
  end

  create_table "mobile_user_events", :force => true do |t|
    t.string   "device_uid"
    t.string   "user_event"
    t.string   "description"
    t.datetime "user_event_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "redemption_passphrases", :force => true do |t|
    t.string   "passphrase"
    t.date     "beg_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "redemptions", :force => true do |t|
    t.integer  "deal_id"
    t.integer  "num_redeemed"
    t.integer  "num_available"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "retailer_categories", :force => true do |t|
    t.string   "retailer_category"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "retailers", :force => true do |t|
    t.integer  "account_id",                          :null => false
    t.integer  "retailer_category_id",                :null => false
    t.string   "name",                                :null => false
    t.string   "address",                             :null => false
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "contact_name",                        :null => false
    t.string   "contact_email",                       :null => false
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "zone",                 :default => 0
  end

  create_table "traffic_cameras", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.decimal  "latitude",         :precision => 10, :scale => 6
    t.decimal  "longitude",        :precision => 10, :scale => 6
    t.string   "url"
    t.integer  "status"
    t.integer  "geocode_flag"
    t.integer  "compass_point_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "traffic_condition_historicals", :force => true do |t|
    t.integer  "traffic_camera_id"
    t.integer  "traffic_rating_id"
    t.integer  "day_of_week"
    t.string   "time_of_day"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "traffic_conditions", :force => true do |t|
    t.integer  "traffic_data_type_id"
    t.integer  "traffic_camera_id"
    t.integer  "traffic_rating_id"
    t.integer  "compass_point_id"
    t.datetime "report_date"
    t.string   "alert_message"
    t.string   "other_source"
    t.string   "other_description"
    t.string   "other_address"
    t.float    "other_latitude"
    t.float    "other_longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "traffic_data_types", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "traffic_ratings", :force => true do |t|
    t.string   "rating"
    t.string   "description"
    t.string   "icon_path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_events", :force => true do |t|
    t.string   "device_uid"
    t.string   "user_event"
    t.string   "description"
    t.datetime "user_event_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.integer  "roles_mask",                            :default => 2
    t.string   "name",                                                  :null => false
    t.integer  "account_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
