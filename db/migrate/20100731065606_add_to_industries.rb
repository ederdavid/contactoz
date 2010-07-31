class AddToIndustries < ActiveRecord::Migration
  def self.up
	add_column :company_industries, :company_id, :int
  end

  def self.down
        remove_column :company_industries, :company_id
  end
end
