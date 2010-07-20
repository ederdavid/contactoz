class AddBusinesses < ActiveRecord::Migration
  def self.up
	 add_column :companies, :scian, :string
	 add_column :companies, :giro, :string
         add_column :companies, :year_started, :string
  end

  def self.down
	 remove_column :companies, :scian
         remove_column :companies, :giro
         remove_column :companies, :year_started
  end
end
