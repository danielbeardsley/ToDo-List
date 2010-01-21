class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :title,          :null => false
      t.date :due,              :null => true
      t.string :type,           :null => false
      t.boolean :completed,     :null => false, :default => false
      t.datetime :last_seen,        :null => true
      t.datetime :date_completed,   :null => true

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
