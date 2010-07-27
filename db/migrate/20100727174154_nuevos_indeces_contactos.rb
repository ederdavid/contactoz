class NuevosIndecesContactos < ActiveRecord::Migration
  def self.up
	 add_index :contacts, [:department]
 	 add_index :contacts, [:company_id]
  end

  def self.down
         remove_index :contacts, [:department]
         remove_index :contacts, [:company_id]
  end
end
