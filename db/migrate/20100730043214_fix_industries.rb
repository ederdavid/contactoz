class FixIndustries < ActiveRecord::Migration
  def self.up
	 remove_index :industries, [:company_id]
	 remove_column :industries, :company_id

  end

  def self.down
	 add_index :industries, [:company_id]
  end
end
