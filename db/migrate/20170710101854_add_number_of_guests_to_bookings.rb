class AddNumberOfGuestsToBookings < ActiveRecord::Migration[5.1]
  def change
    add_column :bookings, :number_of_guests, :integer
  end
end
