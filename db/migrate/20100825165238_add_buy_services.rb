class AddBuyServices < ActiveRecord::Migration
  def self.up
	add_column :services, :buy, :string
  end

  def self.down
	remove_column :services, :buy
  end
end
