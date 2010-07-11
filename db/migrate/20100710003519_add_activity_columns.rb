class AddActivityColumns < ActiveRecord::Migration

  def self.up
     create_table :activity do |t|
     	t.column :created_at, :timestamp
     	t.column :points, :bigint
     	t.column :contact_id, :string
     	t.column :company_id, :string
     end
  end

  def self.down
  end
end
