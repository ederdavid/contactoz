class AddIndustry < ActiveRecord::Migration
  def self.up
	add_column :companies, :industry_id, :int
  end

  def self.down
	remove_column :companies, :industry_id
  end
end
