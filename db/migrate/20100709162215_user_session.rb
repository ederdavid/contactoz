class UserSession < ActiveRecord::Migration
  def self.up
     create_table :user_session do |t|
     	t.column :username, :string
     	t.column :password, :string
     end
  end

  def self.down
     drop_table :user_session
  end
end
