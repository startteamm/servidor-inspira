class CreateActivityTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :activity_types do |t|
      t.string :title, null: false

      t.timestamps
    end
  end
end