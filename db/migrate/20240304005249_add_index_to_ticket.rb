class AddIndexToTicket < ActiveRecord::Migration[7.0]
  def change
    add_index :tickets, :code, unique: true
  end
end
