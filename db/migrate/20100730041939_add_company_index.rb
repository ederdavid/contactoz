class AddCompanyIndex < ActiveRecord::Migration
  def self.up
	 add_index :industries, [:company_id]
  end

  def self.down
	remove_index :industries, [:company_id]
  end
end
