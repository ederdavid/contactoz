class AddSellProduct < ActiveRecord::Migration
  def self.up
	add_column :products, :sell, :string
  end

  def self.down
	remove_column :products, :sell
  end
end
