class AddAgain < ActiveRecord::Migration

  def self.up
        add_column :contacts, :number, :string
        add_column :contacts, :email, :string
  end

  def self.down
        remove_column :contacts, :number
        remove_column :contacts, :email
  end


end
