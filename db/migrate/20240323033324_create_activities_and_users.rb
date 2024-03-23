class CreateActivitiesAndUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :activities_users, id: false do |t|
      t.belongs_to :activity
      t.belongs_to :user
      t.timestamps
    end
  end
end
