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

ActiveRecord::Schema.define(:version => 20100817212348) do

  create_table "actions", :force => true do |t|
    t.datetime "created_at"
    t.string   "entity_changed"
    t.string   "action"
    t.datetime "updated_at"
    t.integer  "points",         :limit => 8
    t.integer  "user_id"
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

  create_table "application_accounts", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "api_key"
    t.string   "api_secret"
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
    t.string   "company_city"
    t.string   "colonia"
    t.string   "scian"
    t.string   "giro"
    t.string   "year_started"
    t.integer  "industry_id"
    t.integer  "company_location_id"
  end

  add_index "companies", ["company_name"], :name => "index_companies_on_company_name"

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
    t.integer  "company_id"
    t.integer  "accuracy"
    t.string   "department"
    t.string   "hierarchy"
    t.string   "address"
  end

  add_index "contacts", ["company_id"], :name => "index_contacts_on_company_id"
  add_index "contacts", ["department"], :name => "index_contacts_on_department"
  add_index "contacts", ["name"], :name => "index_contacts_on_name"

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
    t.string   "contact_email"
    t.string   "contact_number"
    t.date     "date_updated"
  end

  create_table "services", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.text     "description"
    t.integer  "contact_id"
    t.string   "contact_name"
    t.string   "contact_email"
    t.string   "contact_number"
    t.date     "date_updated"
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
  end

  add_index "users", ["perishable_token"], :name => "index_users_on_perishable_token"

  create_table "usuarios", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "api_key",                   :limit => 40,  :default => ""
  end

  add_index "usuarios", ["login"], :name => "index_usuarios_on_login", :unique => true

end
