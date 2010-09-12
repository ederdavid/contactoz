class AddIdFeed < ActiveRecord::Migration
  def self.up
	 add_column :feeds, :contact_id, :int
  end

  def self.down
	 remove_column :feeds, :contact_id
  end
end
