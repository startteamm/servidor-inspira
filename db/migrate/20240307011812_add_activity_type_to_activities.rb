class AddActivityTypeToActivities < ActiveRecord::Migration[7.1]
  def change
    add_reference :activity_types, :activity, foreign_key: true
  end
end