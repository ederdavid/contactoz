class DeleteId < ActiveRecord::Migration
  def self.up
	remove_column :categorizations, :product_id
	remove_column :categorizations, :service_id
  end

  def self.down
	add_column :categorizations, :product_id, :int
	add_column :categorizations, :service_id, :int
  end
end
