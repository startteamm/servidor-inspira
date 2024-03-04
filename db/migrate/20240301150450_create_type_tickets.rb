class CreateTypeTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :type_tickets do |t|
      t.string :name
      t.text :description
      t.float :value

      t.timestamps
    end
  end
end
