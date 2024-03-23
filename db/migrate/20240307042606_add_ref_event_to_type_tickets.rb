class AddRefEventToTypeTickets < ActiveRecord::Migration[7.1]
  def change
    add_reference :type_tickets, :event, null: false, foreign_key: true
  end
end
