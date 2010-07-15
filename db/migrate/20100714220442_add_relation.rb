class AddRelation < ActiveRecord::Migration
  def self.up
	add_column :companies, :contact_id, :int
	add_column :contacts, :company_id, :int
  end

  def self.down
	remove_column :companies, :contact_id
	remove_column :contacts, :company_id
  end
end
