class AddColonia < ActiveRecord::Migration
  def self.up
	add_column :companies, :colonia, :string
  end

  def self.down
	remove_column :companies, :colonia 
  end
end

