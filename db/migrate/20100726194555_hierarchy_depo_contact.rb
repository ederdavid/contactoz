class HierarchyDepoContact < ActiveRecord::Migration
  def self.up
	add_column :contacts, :department, :string
        add_column :contacts, :hierarchy, :string
  end

  def self.down
	delete_column :contacts, :hierarchy
	delete_column :contacts, :department
  end
end
