class CreateProspects < ActiveRecord::Migration
  def self.up
    create_table :prospects do |t|
      t.string :email
      t.int :active

      t.timestamps
    end
  end

  def self.down
    drop_table :prospects
  end
end
