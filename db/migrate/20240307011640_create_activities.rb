class CreateActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :activities do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.string :duration, null: false
      t.string :image
      t.date :date, null: false
      t.string :workload, null: false
      t.time :start_time, null: false
      t.string :location, null: false
      t.integer :capacity, null: false

      t.timestamps
    end
  end
end