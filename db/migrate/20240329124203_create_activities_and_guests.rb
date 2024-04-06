class CreateActivitiesAndGuests < ActiveRecord::Migration[7.0]
  def change
    create_table :activities_guests, id: false do |t|
      t.belongs_to :activity
      t.belongs_to :guest
      t.timestamps
    end
  end
end
