class DeleteActivityTables < ActiveRecord::Migration
  def self.up
  	drop_table :activity
  end

  def self.down
  end
end
