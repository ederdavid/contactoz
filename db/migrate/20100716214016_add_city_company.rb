class AddCityCompany < ActiveRecord::Migration
  def self.up
	add_column :companies, :company_city, :string
  end

  def self.down
	add_column :companies, :company_city
  end
end
