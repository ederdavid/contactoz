class CreateLandings < ActiveRecord::Migration
  def self.up
    create_table :landings do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :landings
  end
end
