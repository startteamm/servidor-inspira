class ChangeImageToBinary < ActiveRecord::Migration[7.0]
  def change
    change_column :activities, :image, :binary, limit: 20.megabytes
  end
end
