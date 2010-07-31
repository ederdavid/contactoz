class MassAIndustries < ActiveRecord::Migration
  def self.up
	add_column :company_industries, :name, :string
  end

  def self.down
	remove_column :company_industries, :name
  end
end
