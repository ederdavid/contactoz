class CreateApplicationAccounts < ActiveRecord::Migration
  def self.up
    create_table :application_accounts do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :application_accounts
  end
end
