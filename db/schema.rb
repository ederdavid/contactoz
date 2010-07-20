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

<<<<<<< HEAD:db/schema.rb
ActiveRecord::Schema.define(:version => 20100719175919) do
=======
ActiveRecord::Schema.define(:version => 20100719165729) do
>>>>>>> bb76e345f8fda188c0a9824e84bdd082f2d628f3:db/schema.rb

  create_table "actions", :force => true do |t|
    t.datetime "created_at"
    t.string   "entity_changed"
    t.string   "action"
    t.datetime "updated_at"
    t.integer  "points",         :limit => 8
    t.integer  "user_id"
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
  end

  create_table "homes", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "plans", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
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

end
