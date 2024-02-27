class CreateActivityTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :activity_types do |t|
      t.integer :title, default: 0

      t.timestamps
    end
  end
end
