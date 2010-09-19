class EditColumns < ActiveRecord::Migration
  def self.up
	add_column :advert_categorizations, :topic_id, :int
  end

  def self.down
        remove_column :advert_categorizations, :topic_id, :int

  end
end
