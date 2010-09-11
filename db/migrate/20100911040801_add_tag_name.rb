class AddTagName < ActiveRecord::Migration
  def self.up
	 add_column :topics, :tag_name, :string
  end

  def self.down
	 remove_column :topics, :tag_name
  end
end
