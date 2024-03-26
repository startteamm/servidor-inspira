class CreateActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :activities do |t|
      t.string :image
      t.string :title, null: false
      t.date :date, null: false
      t.time :time, null: false
      t.string :speakers_full_name, null: false
      t.string :speakers_jobs, null: false

      t.timestamps
    end
  end
end