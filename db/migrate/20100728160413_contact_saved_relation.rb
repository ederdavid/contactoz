class ContactSavedRelation < ActiveRecord::Migration
  def self.up
	 add_column :contact_saveds, :contact_id, :integer
  end

  def self.down
	remove_column :contact_saveds, :contact_id
  end
end
