class Usertoaction < ActiveRecord::Migration
  def self.up
  	add_column :actions, :user_id, :int
  end

  def self.down
        remove_column :actions, :user_id
  end
end
