class RemoveUserDefaults < ActiveRecord::Migration[7.1]
  def change
    change_column_default :users, :email, nil
    change_column_default :users, :encrypted_password, nil
    change_column_default :users, :full_name, nil
    change_column_default :users, :phone, nil
  end
end
