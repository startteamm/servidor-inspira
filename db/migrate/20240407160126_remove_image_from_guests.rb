class RemoveImageFromGuests < ActiveRecord::Migration[7.0]
  def change
    remove_column :guests, :image, :string
  end
end
