class IndustryString < ActiveRecord::Migration
  def self.up
	add_column :industries, :name, :string
  end

  def self.down
	remove_column :industries, :name
  end
end
