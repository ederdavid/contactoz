class DeleteContactFields3 < ActiveRecord::Migration
  def self.up
      add_column :contacts, :accuracy, :int
  end

  def self.down
     remove_column :contacts, :accuracy
  end
end
