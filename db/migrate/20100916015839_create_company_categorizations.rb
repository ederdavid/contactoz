class CreateCompanyCategorizations < ActiveRecord::Migration
  def self.up
    create_table :company_categorizations do |t|
      t.int :company_id
      t.int :topic_id

      t.timestamps
    end
  end

  def self.down
    drop_table :company_categorizations
  end
end
