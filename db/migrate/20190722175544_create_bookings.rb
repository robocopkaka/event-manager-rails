class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.references :user, foreign_key: true, index: true, unique: true
      t.references :event, foreign_key: true, index: true, unique: true

      t.timestamps
    end
  end
end
