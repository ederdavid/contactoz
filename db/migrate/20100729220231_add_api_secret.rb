class AddApiSecret < ActiveRecord::Migration
  def self.up
      add_column :application_accounts, :api_key, :string
      add_column :application_accounts, :api_secret, :string
  end

  def self.down
      remove_column :application_accounts, :api_key
      remove_column :application_accounts, :api_secret
  end
end
