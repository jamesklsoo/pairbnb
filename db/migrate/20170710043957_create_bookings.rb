class CreateBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :bookings do |t|
      t.string :date_start, null: false
      t.string :date_end, null: false
      t.references :user, index: true, foreign_key: true
      t.references :listing, index: true, foreign_key: true
      t.timestamps
    end
  end
end
