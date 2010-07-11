class AddActivityColumns2 < ActiveRecord::Migration
  def self.up
  	 add_column :activity, :change, :string
         add_column :activity, :action, :string
         remove_column :activity, :contact_id
         remove_column :activity, :company_id
  end

  def self.down
	 remove_column :activity, :change, :string
	 remove_column :activity, :action, :string
         add_column :activity, :contact_id
         add_column :activity, :company_id
  end
end
