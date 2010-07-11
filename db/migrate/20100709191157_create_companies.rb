class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
      t.string :company_site
      t.string :company_name
      t.string :company_postcode
      t.string :company_address
      t.string :company_state
      t.date :company_date_updated
      t.string :linkedin_id
      t.int :industry_id
      t.date :date_created
      t.string :company_phone
      t.string :company_fax
      t.string :employee_number
      t.string :revenue
      t.string :fb_id
      t.string :company_ownership
      t.int :company_contact_id
      t.text :company_overview
      t.string :last_update_user_id
      t.string :activity_id

      t.timestamps
    end
  end

  def self.down
    drop_table :companies
  end
end
