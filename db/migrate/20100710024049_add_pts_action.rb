class AddPtsAction < ActiveRecord::Migration
  def self.up
    add_column :actions, :points, :bigint

  end

  def self.down
    remove_column :actions, :points
  end
end
