class CreateDisplaycontacts < ActiveRecord::Migration
  def self.up
    create_table :displaycontacts do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :displaycontacts
  end
end
