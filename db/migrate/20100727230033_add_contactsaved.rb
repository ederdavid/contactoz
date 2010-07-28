class AddContactsaved < ActiveRecord::Migration
  def self.up
	 add_column :contact_saveds, :user_id, :integer
  end

  def self.down
	remove_column :contact_saveds, :user_id
  end

end
