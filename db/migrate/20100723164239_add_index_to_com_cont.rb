class AddIndexToComCont < ActiveRecord::Migration
  def self.up
	 add_index :contacts, [:name]
	 add_index :companies, [:company_name]

  end

  def self.down
	remove_index :company, [:company_name]
	remove_index :contacts, [:name]
  end
end
