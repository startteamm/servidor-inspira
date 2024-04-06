class AddRefUserToTickets < ActiveRecord::Migration[7.0]
  def change
    add_reference :tickets, :user, null: false, foreign_key: true
  end
end
