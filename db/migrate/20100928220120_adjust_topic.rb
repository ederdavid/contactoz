class AdjustTopic < ActiveRecord::Migration
  def self.up
	remove_column :topics, :specific
  end

  def self.down
        add_column :topics, :specific, :int
  end
end
