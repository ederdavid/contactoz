class SpecificBool < ActiveRecord::Migration
  def self.up
	add_column :topics, :specific_bool, :int
        remove_column :topics, :type
  end

  def self.down
        remove_column :topics, :specific_bool
        add_column :topics, :type, :int
  end
end
