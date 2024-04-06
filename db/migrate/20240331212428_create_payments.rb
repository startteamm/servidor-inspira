class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.text :response
      t.string :x_idempotency_key
      t.integer :tipo
      t.integer :status, default: 0
      t.references :user, :type_ticket

      t.timestamps
    end
  end
end
