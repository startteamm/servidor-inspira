class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :title, null: false
      t.text :description
      t.float :price
      t.string :promotional_price
      t.string :image
      t.integer :status
      t.string :type
      t.integer :stock_quantity, default: 0
      t.integer :stock_status
      t.integer :user_purchase_limit
      t.bigint :creator
      t.bigint :last_editor

      t.timestamps
    end
  end
end
