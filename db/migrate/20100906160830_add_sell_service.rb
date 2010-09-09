class AddSellService < ActiveRecord::Migration
  def self.up
	add_column :services, :sell, :string
  end

  def self.down
	remove_column :services, :sell
  end
end
