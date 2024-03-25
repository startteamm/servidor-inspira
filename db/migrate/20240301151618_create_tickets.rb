class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.string :code
      t.boolean :validated, default: false

      t.timestamps
    end
  end
end
