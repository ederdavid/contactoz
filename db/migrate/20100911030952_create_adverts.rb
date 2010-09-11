class CreateAdverts < ActiveRecord::Migration
  def self.up
    create_table :adverts do |t|
      t.string :name
      t.string :picture
      t.string :price
      t.text :description
      t.int :company_id

      t.timestamps
    end
  end

  def self.down
    drop_table :adverts
  end
end
