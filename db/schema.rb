# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101004192252) do

  create_table "access_tokens", :force => true do |t|
    t.integer  "user_id"
    t.string   "type",       :limit => 30
    t.string   "key"
    t.string   "token",      :limit => 1024
    t.string   "secret"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "access_tokens", ["key"], :name => "index_access_tokens_on_key", :unique => true

  create_table "actions", :force => true do |t|
    t.datetime "created_at"
    t.string   "entity_changed"
    t.string   "action"
    t.datetime "updated_at"
    t.integer  "points",         :limit => 8
    t.integer  "user_id"
  end

  create_table "advert_categorizations", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "topic_id"
    t.integer  "advertisement_id"
  end

  create_table "advertisements", :force => true do |t|
    t.string   "name"
    t.string   "picture"
    t.string   "price"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
  end

  create_table "adverts", :force => true do |t|
    t.string   "name"
    t.string   "picture"
    t.string   "price"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "application_accounts", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "api_key"
    t.string   "api_secret"
  end

  create_table "categorizations", :force => true do |t|
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "feed_id"
  end

  create_table "companies", :force => true do |t|
    t.string   "company_site"
    t.string   "company_name"
    t.string   "company_postcode"
    t.string   "company_address"
    t.string   "company_state"
    t.string   "linkedin_id"
    t.string   "company_phone"
    t.string   "company_fax"
    t.string   "employee_number"
    t.string   "revenue"
    t.string   "fb_id"
    t.string   "company_ownership"
    t.text     "company_overview"
    t.string   "last_update_user_id"
    t.string   "activity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "contact_id"
    t.string   "colonia"
    t.string   "scian"
    t.string   "giro"
    t.string   "year_started"
    t.string   "company_city"
    t.integer  "company_location_id"
    t.string   "source"
  end

  add_index "companies", ["company_name"], :name => "index_companies_on_company_name"

  create_table "company_categorizations", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.integer  "topic_id"
  end

  create_table "company_industries", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.string   "name"
  end

  create_table "company_locations", :force => true do |t|
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "code"
    t.string   "phone_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
  end

  create_table "companycontacts", :force => true do |t|
    t.string   "title"
    t.string   "name"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "linkedin_id"
    t.date     "contact_last_updated"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "accuracy"
    t.integer  "company_id"
    t.string   "department"
    t.string   "hierarchy"
  end

  create_table "contact_saveds", :force => true do |t|
    t.string   "title"
    t.string   "name"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "linkedin_id"
    t.string   "contact_last_updated"
    t.date     "created_at"
    t.datetime "updated_at"
    t.string   "purchased"
    t.integer  "company_id"
    t.string   "department"
    t.string   "hierarchy"
    t.string   "address"
    t.integer  "user_id"
    t.integer  "contact_id"
  end

  create_table "contacts", :force => true do |t|
    t.string   "title"
    t.string   "name"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "linkedin_id"
    t.date     "contact_last_updated"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "accuracy"
    t.integer  "company_id"
    t.string   "department"
    t.string   "hierarchy"
    t.string   "address"
  end

  add_index "contacts", ["company_id"], :name => "index_contacts_on_company_id"
  add_index "contacts", ["department"], :name => "index_contacts_on_department"
  add_index "contacts", ["name"], :name => "index_contacts_on_name"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.text     "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "display_companies", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "displaycontacts", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "displays", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feed_entries", :force => true do |t|
    t.string   "name"
    t.text     "summary"
    t.string   "url"
    t.datetime "published_at"
    t.string   "guid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feeds", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "contact_name"
    t.string   "contact_phone"
    t.string   "contact_email"
    t.string   "contact_title"
    t.string   "buy"
    t.string   "sell"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "contact_id"
  end

  create_table "homes", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "imports", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "industries", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "contact_id"
    t.integer  "company_id"
  end

  add_index "industries", ["company_id"], :name => "index_industries_on_company_id"

  create_table "landings", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "news", :force => true do |t|
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "news_categorizations", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "plans", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.text     "description"
    t.integer  "contact_id"
    t.string   "contact_name"
    t.string   "contact_phone"
    t.string   "contact_email"
    t.string   "contact_title"
    t.string   "buy"
    t.string   "sell"
  end

  create_table "registers", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "services", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.text     "description"
    t.integer  "contact_id"
    t.string   "contact_name"
    t.string   "contact_phone"
    t.string   "contact_email"
    t.string   "contact_title"
    t.string   "buy"
    t.string   "sell"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "taggable_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "topics", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tag_name"
    t.integer  "service_id"
    t.integer  "product_id"
    t.integer  "user_id"
    t.string   "company"
    t.text     "related"
    t.integer  "specific_bool"
  end

  create_table "user_session", :force => true do |t|
    t.string "username"
    t.string "password"
  end

  create_table "users", :force => true do |t|
    t.string   "screen_name"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "profession"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.string   "level"
    t.string   "rating"
    t.date     "date_created"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "action_id"
    t.integer  "points",            :limit => 8
    t.string   "perishable_token",               :default => "",    :null => false
    t.boolean  "active",                         :default => false, :null => false
    t.string   "firstname"
    t.string   "lastname"
  end

  add_index "users", ["perishable_token"], :name => "index_users_on_perishable_token"

end
