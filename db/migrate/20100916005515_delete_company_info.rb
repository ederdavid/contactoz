class DeleteCompanyInfo < ActiveRecord::Migration
  def self.up
  	remove_column :companies, :industry_id
  end

  def self.down
        add_column :companies, :industry_id, :int
  end
end
