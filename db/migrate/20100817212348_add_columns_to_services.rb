class AddColumnsToServices < ActiveRecord::Migration
  def self.up
	add_column :services, :name, :string
	add_column :services, :description, :text
	add_column :services, :contact_id, :int
	add_column :services, :contact_name, :string
	add_column :services, :contact_email, :string
	add_column :services, :contact_number, :string
	add_column :services, :date_updated, :date
  end

  def self.down
	remove_column :services, :name
	remove_column :services, :description
	remove_column :services, :contact_id
	remove_column :services, :contact_name
	remove_column :services, :contact_email
	remove_column :services, :contact_number
	remove_column :services, :date_updated
  end
end
