class RemoveBadColumnscd < ActiveRecord::Migration
  def self.up
	remove_column :contacts, :date_updated
	remove_column :contacts, :date_created
	remove_column :companies, :company_date_updated
	remove_column :companies, :date_created
  end

  def self.down
	add_column :contacts, :date_updated, :date
	add_column :contacts, :date_created, :date
	add_column :companies, :company_date_updated, :date
	add_column :companies, :date_created, :date
  end
end
