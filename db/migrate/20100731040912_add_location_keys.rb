class AddLocationKeys < ActiveRecord::Migration
  def self.up
       add_column :companies, :company_location_id, :int
  end

  def self.down
	remove_column :companies, :company_location_id
  end
end
