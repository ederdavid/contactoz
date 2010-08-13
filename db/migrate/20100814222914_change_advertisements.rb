class ChangeAdvertisements < ActiveRecord::Migration

  def self.up
    create_table :advertisements do |t|
      t.int :company_id
      t.string :name
      t.string :picture
      t.string :price
      t.text :description
      t.timestamps
    end
  end

  def self.down
    drop_table :advertisements
  end
end
