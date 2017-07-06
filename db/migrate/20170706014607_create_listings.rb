class CreateListings < ActiveRecord::Migration[5.1]
  def change
    create_table :listings do |t|
      t.string :name
      t.integer :property_type
      t.integer :room_number
      t.integer :bed_number
      t.integer :guest_number
      t.string :country
      t.string :state
      t.string :city
      t.string :zipcode
      t.string :address
      t.integer :price
      t.string :description
      t.belongs_to :user, index: true
      t.date :start_date
      t.date :end_date
      t.timestamps
    end
  end
end
