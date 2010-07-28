class CreateDisplayCompanies < ActiveRecord::Migration
  def self.up
    create_table :display_companies do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :display_companies
  end
end
