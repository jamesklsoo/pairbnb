class CreateListings < ActiveRecord::Migration[5.1]
  def change
    create_table :listings do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.string :house_rules, null: false
      t.string :number_of_beds, null: false
      t.string :number_of_guests, null: false
      t.string :number_of_bedrooms, null: false
      t.string :number_of_bathrooms, null: false
      t.string :street, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.string :country, null: false
      t.string :price, null: false
      t.string :date_start, null: false
      t.string :date_end, null: false
      t.references :user, index: true, foreign_key: true
      t.timestamps
    end
  end
end
