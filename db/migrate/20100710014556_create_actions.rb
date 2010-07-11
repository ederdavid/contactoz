class CreateActions < ActiveRecord::Migration
  def self.up
    create_table :actions do |t|
      t.timestamp :created_at
      t.bigint :points
      t.string :entity_changed
      t.string :action
      t.int :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :actions
  end
end
