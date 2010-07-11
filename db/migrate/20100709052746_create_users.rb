class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :screen_name
      t.string :first_name
      t.string :last_name
      t.string :profession
      t.string :email
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token 
      t.string :activity_id
      t.string :level
      t.string :rating
      t.bigint :points
      t.date :date_created
      t.bigint :data_contribution

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
