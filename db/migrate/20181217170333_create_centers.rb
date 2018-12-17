class CreateCenters < ActiveRecord::Migration[5.2]
  def change
    create_table :centers do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.string :address, null: false
      t.integer :capacity, default: 0, null: false

      t.timestamps
    end
  end
end
