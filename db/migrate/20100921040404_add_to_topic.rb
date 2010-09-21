class AddToTopic < ActiveRecord::Migration
  def self.up
	add_column :topics, :company, :string
  end

  def self.down
	remove_column :topics, :company
  end
end
