class AddToLanding < ActiveRecord::Migration
  def self.up
	add_column, :landings, :email, :string
  end

  def self.down
  end
end
