class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.string :cleanliness, null: false
      t.string :communication, null: false
      t.string :location, null: false
      t.string :value, null: false
      t.string :comment, null: false
      t.references :listing, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.timestamps
    end
  end
end
