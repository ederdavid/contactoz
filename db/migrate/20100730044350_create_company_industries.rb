class CreateCompanyIndustries < ActiveRecord::Migration
  def self.up
    create_table :company_industries do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :company_industries
  end
end
