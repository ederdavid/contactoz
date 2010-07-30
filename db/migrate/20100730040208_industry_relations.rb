class IndustryRelations < ActiveRecord::Migration
  def self.up
	add_column :industries, :company_id, :string
	add_column :industries, :contact_id, :string
  end

  def self.down
	remove_column :industries, :contact_id
	remove_column :industries, :company_id
  end
end
