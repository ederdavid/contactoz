class AddToService < ActiveRecord::Migration
  def self.up
	add_column :services, :name, :string
        add_column :services, :description, :text
        add_column :services, :contact_id, :int
        add_column :services, :contact_name, :string
	add_column :services, :contact_phone, :string
        add_column :services, :contact_email, :string
        add_column :services, :contact_title, :string        
  end

  def self.down
        remove_column :services, :name, :string
        remove_column :services, :description, :text
        remove_column :services, :contact_id, :int
        remove_column :services, :contact_name, :string
        remove_column :services, :contact_phone, :string
        remove_column :services, :contact_email, :string
        remove_column :services, :contact_title, :string 
  end
end
