class AddImageToCenters < ActiveRecord::Migration[5.2]
  def change
    add_column :centers, :image, :string, default: ''
  end
end
