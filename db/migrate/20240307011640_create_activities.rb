class CreateActivities < ActiveRecord::Migration[7.1]
  def change
    create_table :activities do |t|
      t.string :image
      t.string :title, null: false
      t.date :date, null: false, default: Date.today
      t.time :time, null: false, default: Time.now
      t.string :speaker_name
      t.string :speaker_surname
      t.string :speaker_job

      t.timestamps
    end
  end
end