class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.text :description
      t.string :link
      t.integer :status
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.string :cep
      t.string :street
      t.string :city
      t.string :neighborhood
      t.string :link_google_maps
      t.boolean :publico, default: false
      t.date :start_date_sale_ticket
      t.date :end_date_sale_ticket

      t.timestamps
    end
  end
end
