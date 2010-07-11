class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :title
      t.string :name
      t.int :company_id
      t.string :city
      t.string :state
      t.string :country
      t.date :date_updated
      t.string :linkedin_id
      t.int :industry_id
      t.date :date_created
      t.date :contact_last_updated

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
