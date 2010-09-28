class AddSpecific < ActiveRecord::Migration
  def self.up
	add_column :topics, :related, :text
  end

  def self.down
        remove_column :topics, :related
  end
end
