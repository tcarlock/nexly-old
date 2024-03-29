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

ActiveRecord::Schema.define(:version => 20120212063847) do

  create_table "authentications", :force => true do |t|
    t.integer  "platform_id"
    t.string   "uid"
    t.string   "token"
    t.string   "secret"
    t.integer  "business_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authentications", ["business_id", "platform_id"], :name => "index_authentications_on_business_id_and_platform_id"

  create_table "beta_signups", :force => true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "business_users", :force => true do |t|
    t.integer  "user_id"
    t.integer  "business_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "businesses", :force => true do |t|
    t.string   "name"
    t.string   "facebook"
    t.string   "website"
    t.string   "twitter"
    t.string   "google_plus"
    t.string   "linked_in"
    t.string   "api_token"
    t.text     "biography"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.decimal  "latitude",            :precision => 15, :scale => 10
    t.decimal  "longitude",           :precision => 15, :scale => 10
    t.integer  "industry_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "phone"
    t.text     "preferences"
  end

  create_table "feature_subscriptions", :force => true do |t|
    t.integer  "feature_id"
    t.integer  "business_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "features", :force => true do |t|
    t.string   "title"
    t.text     "details"
    t.float    "price"
    t.boolean  "is_public",     :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "icon"
    t.integer  "display_order"
    t.string   "lookup_key"
  end

  create_table "inquiries", :force => true do |t|
    t.string   "first_name"
    t.string   "email"
    t.text     "details"
    t.integer  "business_id"
    t.boolean  "is_reviewed", :default => false
    t.boolean  "is_archived", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "last_name"
  end

  add_index "inquiries", ["business_id"], :name => "index_inquiries_on_business_id"

  create_table "news_posts", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "business_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "page_views", :force => true do |t|
    t.text     "url"
    t.integer  "business_id"
    t.integer  "resource_id"
    t.integer  "resource_type_id"
    t.integer  "platform_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ip_address"
    t.integer  "channel_type_id"
  end

  add_index "page_views", ["resource_id", "business_id", "platform_id", "resource_type_id", "channel_type_id"], :name => "index_page_views_multi_col"

  create_table "platform_pages", :force => true do |t|
    t.integer  "platform_id"
    t.integer  "business_id"
    t.string   "external_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "platform_pages", ["external_id", "business_id", "platform_id"], :name => "index_platform_pages_multi_col"

  create_table "platform_suggestions", :force => true do |t|
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "platforms", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "icon"
    t.integer  "display_order"
    t.string   "details"
    t.boolean  "is_available",  :default => true
    t.string   "display_name"
  end

  add_index "platforms", ["name"], :name => "index_platforms_on_name"

  create_table "recommendations", :force => true do |t|
    t.string   "first_name"
    t.string   "email"
    t.text     "message"
    t.integer  "business_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "last_name"
  end

  add_index "recommendations", ["business_id"], :name => "index_recommendations_on_business_id"

  create_table "resource_types", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resources", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "link"
    t.integer  "resource_type_id"
    t.integer  "business_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
  end

  create_table "review_requests", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "message"
    t.string   "token"
    t.boolean  "is_reviewed", :default => false
    t.integer  "business_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "review_requests", ["business_id"], :name => "index_review_requests_on_business_id"

  create_table "review_responses", :force => true do |t|
    t.text     "response"
    t.integer  "review_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviews", :force => true do |t|
    t.string   "first_name"
    t.string   "email"
    t.text     "details"
    t.integer  "rating"
    t.boolean  "is_under_review",     :default => false
    t.boolean  "is_approved",         :default => false
    t.boolean  "is_rejected",         :default => false
    t.integer  "business_id"
    t.boolean  "is_anon",             :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "review_request_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "last_name"
  end

  add_index "reviews", ["business_id"], :name => "index_reviews_on_business_id"

  create_table "suggestions", :force => true do |t|
    t.text     "details"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "tracking_links", :force => true do |t|
    t.integer  "business_id"
    t.string   "in_url"
    t.text     "out_url"
    t.integer  "http_status", :default => 301
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tracking_links", ["business_id"], :name => "index_tracking_links_on_business_id"
  add_index "tracking_links", ["in_url"], :name => "index_links_on_in_url"

  create_table "user_profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "google_plus"
    t.string   "linked_in"
    t.text     "biography"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.decimal  "latitude",            :precision => 15, :scale => 10
    t.decimal  "longitude",           :precision => 15, :scale => 10
    t.string   "screen_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "user_profiles", ["user_id"], :name => "index_user_profiles_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "",    :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                                 :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
