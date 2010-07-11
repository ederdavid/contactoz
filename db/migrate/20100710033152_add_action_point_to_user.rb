class AddActionPointToUser < ActiveRecord::Migration
  def self.up
  	  add_column :users, :action_id, :integer
          add_column :users, :points, :bigint
          remove_column :users, :activity_id
  end

  def self.down
 	  add_column :users, :activity_id
	  remove_column :users, :action_id
	  remove_column :users, :points
  end
end
