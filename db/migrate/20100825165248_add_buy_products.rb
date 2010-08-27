class AddBuyProducts < ActiveRecord::Migration
  def self.up
	add_column :products, :buy, :string
  end

  def self.down
	remove_column :products, :buy
  end
end
