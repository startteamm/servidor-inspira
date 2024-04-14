class AddsImageToTypeTickets < ActiveRecord::Migration[7.0]
  def change
    add_column :type_tickets, :image, :string
  end
end
