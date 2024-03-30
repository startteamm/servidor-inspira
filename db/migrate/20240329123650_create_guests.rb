class CreateGuests < ActiveRecord::Migration[7.0]
  def change
    create_table :guests do |t|
      t.string :full_name, null: false
      t.string :email, null: false
      t.text :description, null: false
      t.string :image

      
      t.timestamps
    end
  end
end
