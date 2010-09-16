class CreateAdvertCategorizations < ActiveRecord::Migration
  def self.up
    create_table :advert_categorizations do |t|
      t.int :advertisement_id
      t.int :topic_id

      t.timestamps
    end
  end

  def self.down
    drop_table :advert_categorizations
  end
end
