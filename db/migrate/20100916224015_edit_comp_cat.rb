class EditCompCat < ActiveRecord::Migration
  def self.up
	add_column :company_categorizations, :company_id, :int
        add_column :company_categorizations, :topic_id, :int
  end

  def self.down
        remove_column :company_categorizations, :company_id
        remove_column :company_categorizations, :topic_id
  end
end
