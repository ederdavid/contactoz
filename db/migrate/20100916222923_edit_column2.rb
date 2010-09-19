class EditColumn2 < ActiveRecord::Migration
  def self.up
	        add_column :advert_categorizations, :advertisement_id, :int
  end

  def self.down
                remove_column :advert_categorizations, :advertisement_id

  end
end
