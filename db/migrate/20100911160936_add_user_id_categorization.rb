class AddUserIdCategorization < ActiveRecord::Migration
  def self.up
	add_column :categorizations, :user_id, :int
  end

  def self.down
        remove_column :categorizations, :user_id, :int
  end
end
