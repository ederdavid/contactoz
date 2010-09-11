class AddUserIdTopics < ActiveRecord::Migration
  def self.up
	add_column :topics, :user_id, :int
  end

  def self.down
        remove_column :topics, :user_id, :int
  end
end
