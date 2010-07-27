class AddAddressContact < ActiveRecord::Migration
  def self.up
	add_column :contacts, :address, :string
  end

  def self.down
	remove_column :contacts, :address
  end
end
