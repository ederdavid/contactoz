class AddIdForTopics < ActiveRecord::Migration
  def self.up
         add_column :topics, :service_id, :int
	 add_column :topics, :product_id, :int
  end

  def self.down
         remove_column :topics, :service_id
         remove_column :topics, :product_id
  end
end
