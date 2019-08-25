class RemoveAddressFromCenters < ActiveRecord::Migration[5.2]
  def change
    remove_column :centers, :address
  end
end
