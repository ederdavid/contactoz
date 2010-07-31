class AddCompidLocation < ActiveRecord::Migration
  def self.up
	add_column :company_locations, :company_id, :int
  end

  def self.down
        delete_column :company_locations, :company_id
  end
end
