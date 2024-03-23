class AddActivityTypeToActivities < ActiveRecord::Migration[7.1]
  def change
    add_reference :activities, :activity_type, foreign_key: true
  end
end