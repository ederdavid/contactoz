class AddCompanyId < ActiveRecord::Migration
  def self.up
	add_column :advertisements, :company_id, :int
  end

  def self.down
	remove_column :advertisements, :company_id
  end
end
