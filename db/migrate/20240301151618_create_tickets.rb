class CreateTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :tickets, id: false do |t|
      t.string :id, null: false, primary_key: true, default: -> { "UUID()" }
      t.string :code
      t.boolean :validated, default: false

      t.timestamps
    end
  end
end
