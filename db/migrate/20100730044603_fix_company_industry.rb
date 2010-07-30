class FixCompanyIndustry < ActiveRecord::Migration
  def self.up
 	add_column :industries, :company_id, :int
        add_index :industries, [:company_id]
  end

  def self.down
	remove_column :industries, :company_id, :int
        remove_index :industries, [:company_id]
  end
end
