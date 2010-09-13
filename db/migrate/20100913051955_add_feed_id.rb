class AddFeedId < ActiveRecord::Migration
  def self.up
	 add_column :categorizations, :feed_id, :int
  end

  def self.down
         remove_column :categorizations, :feed_id
  end
end
