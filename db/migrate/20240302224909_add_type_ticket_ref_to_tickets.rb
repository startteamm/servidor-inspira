class AddTypeTicketRefToTickets < ActiveRecord::Migration[7.0]
  def change
    add_reference :tickets, :type_ticket, null: false, foreign_key: true
  end
end
