class AddUserRefToTickets < ActiveRecord::Migration[7.1]
  def change
    add_reference :tickets, :type_ticket, null: false, foreign_key: true
  end
end
