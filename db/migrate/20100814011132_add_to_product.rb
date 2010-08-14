class AddToProduct < ActiveRecord::Migration

 def self.up
        add_column :products, :name, :string
        add_column :products, :description, :text
        add_column :products, :contact_id, :int
        add_column :products, :contact_name, :string
        add_column :products, :contact_phone, :string
        add_column :products, :contact_email, :string
        add_column :products, :contact_title, :string
  end

  def self.down
        remove_column :products, :name, :string
        remove_column :products, :description, :text
        remove_column :products, :contact_id, :int
        remove_column :products, :contact_name, :string
        remove_column :products, :contact_phone, :string
        remove_column :products, :contact_email, :string
        remove_column :products, :contact_title, :string
  end

end
