class CreateNewsCategorizations < ActiveRecord::Migration
  def self.up
    create_table :news_categorizations do |t|
      t.news_id :int
      t.topic_id :int

      t.timestamps
    end
  end

  def self.down
    drop_table :news_categorizations
  end
end
