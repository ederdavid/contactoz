class CreateCompanyLocations < ActiveRecord::Migration
  def self.up
    create_table :company_locations do |t|
      t.int :company_id
   
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.string :code
      t.string :phone_number

      t.timestamps
    end
  end

  def self.down
    drop_table :company_locations
  end
end
