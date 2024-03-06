class CreateAppAuths < ActiveRecord::Migration[7.1]
  def change
    create_table :app_auths do |t|
      t.string :employee_name
      t.integer :celula
      t.string :code, null: false
      t.string :key_digest
      t.timestamp :last_created_key_at
      t.boolean :ativo, default: false
      t.timestamp :activation_at

      t.timestamps
    end
  end
end
