class ChangeTopic < ActiveRecord::Migration
  def self.up
	add_column :topics, :type, :int
  end

  def self.down
	remove_column :topics, :type
  end
end
