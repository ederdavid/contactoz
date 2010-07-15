class CreateContactSaveds < ActiveRecord::Migration
  def self.up
    create_table :contact_saveds do |t|
      t.string :title
      t.string :name
      t.int :company_id
      t.string :city
      t.string :state
      t.string :country
      t.string :linkedin_id
      t.int :accuracy
      t.string :contact_last_updated
      t.date :created_at
      t.timestamp :updated_at
      t.int :accuracy
      t.string :purchased

      t.timestamps
    end
  end

  def self.down
    drop_table :contact_saveds
  end
end
