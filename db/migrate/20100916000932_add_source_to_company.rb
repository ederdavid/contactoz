class AddSourceToCompany < ActiveRecord::Migration
  def self.up
	 add_column :companies, :source, :string
  end

  def self.down
         remove_column :companies, :source
  end
end
