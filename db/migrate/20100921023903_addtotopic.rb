class Addtotopic < ActiveRecord::Migration
  def self.up
	add_column :topics, :specific, :string
  end

  def self.down
	remove_column :topics, :specific
  end
end
