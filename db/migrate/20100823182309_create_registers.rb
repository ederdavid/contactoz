class CreateRegisters < ActiveRecord::Migration
  def self.up
    create_table :registers do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :registers
  end
end
