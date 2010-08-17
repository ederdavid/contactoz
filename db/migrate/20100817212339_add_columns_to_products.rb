class AddColumnsToProducts < ActiveRecord::Migration
  def self.up
	add_column :products, :name, :string
	add_column :products, :description, :text
	add_column :products, :contact_id, :int
	add_column :products, :contact_name, :string
	add_column :products, :contact_email, :string
	add_column :products, :contact_number, :string
	add_column :products, :date_updated, :date
  end

  def self.down
	remove_column :products, :name
	remove_column :products, :description
	remove_column :products, :contact_id
	remove_column :products, :contact_name
	remove_column :products, :contact_email
	remove_column :products, :contact_number
	remove_column :products, :date_updated
  end
end
