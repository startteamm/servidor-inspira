class CreateActivityTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :activity_types do |t|
      t.string :title, null: false, default: ""

      t.timestamps
    end
  end
end