class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string :name
      t.integer :accompanying_number
      t.boolean :is_confirmed, default: false
      t.integer :confirmed_accompanying_number

      t.timestamps null: false
    end
  end
end
