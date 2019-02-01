class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.integer :guests, default: 0, null: false
      t.datetime :datetime, null: false
      t.text :description, default: ''
      t.references :center, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
