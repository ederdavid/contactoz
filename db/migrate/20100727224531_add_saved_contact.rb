class AddSavedContact < ActiveRecord::Migration
  def self.up
	add_column :contact_saveds, :company_id, :integer
	add_column :contact_saveds, :department, :string        
        add_column :contact_saveds, :hierarchy, :string	
        add_column :contact_saveds, :address, :string
  end

  def self.down
        remove_column :contact_saveds, :company_id
        remove_column :contact_saveds, :department
        remove_column :contact_saveds, :hierarchy
        remove_column :contact_saveds, :address
  end
end
