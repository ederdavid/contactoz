class CreateFeeds < ActiveRecord::Migration
  def self.up
    create_table :feeds do |t|
      t.string :name
      t.text :description
      t.int :contact_id
      t.string :contact_name
      t.string :contact_phone
      t.string :contact_email
      t.string :contact_title
      t.string :buy
      t.string :sell
      t.string :type

      t.timestamps
    end
  end

  def self.down
    drop_table :feeds
  end
end
