class CreateDisplays < ActiveRecord::Migration
  def self.up
    create_table :displays do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :displays
  end
end
