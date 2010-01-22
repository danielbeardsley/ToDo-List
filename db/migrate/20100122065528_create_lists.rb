class CreateLists < ActiveRecord::Migration
  def self.up
    create_table :lists do |t|
      t.string :name
      t.integer :current_item_id

      t.timestamps
    end

    add_column :items, :list_id, :integer
    remove_column :items, :type
  end

  def self.down
    drop_table :lists
    remove_column :items, :list_id, :integer
    add_column :items, :type, :string
  end
end
