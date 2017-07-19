# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = {}
user['password'] = 'asdf'

ActiveRecord::Base.transaction do
  20.times do
    user['first_name'] = Faker::Name.first_name
    user['last_name'] = Faker::Name.last_name
    user['email'] = Faker::Internet.email
    user['gender'] = rand(1..2)
    user['phone_number'] = Faker::PhoneNumber.phone_number
    #user['country'] = Faker::Address.country
    user['birthday'] = Faker::Date.between(50.years.ago, Date.today)
    user['government_id'] = Faker::Number.number(12)
    user['location'] = Faker::Address.city

    User.create(user)
  end
end

# Seed Listings
listing = {}
uids = []
User.all.each { |u| uids << u.id }

ActiveRecord::Base.transaction do
  40.times do
    listing['name'] = Faker::App.name
    #listing['property_type'] = ["House", "Entire Floor", "Condominium", "Villa", "Townhouse", "Castle", "Treehouse", "Igloo", "Yurt", "Cave", "Chalet", "Hut", "Tent", "Other"].sample
    listing['number_of_beds'] = rand(1..5)

    listing['number_of_bedrooms'] = rand(0..5)
    listing['number_of_bathrooms'] = rand(1..6)
    listing['number_of_guests'] = rand(1..10)

    listing['country'] = Faker::Address.country
    listing['state'] = Faker::Address.state
    listing['city'] = Faker::Address.city
    listing['street'] = Faker::Address.street_address

    listing['price'] = rand(80..500)
    listing['description'] = Faker::Hipster.sentence
    listing['house_rules'] = Faker::Hipster.sentence

    listing['date_start'] = Faker::Date.between(Date.today, 2.weeks.from_now)
    listing['date_end'] = Faker::Date.between(2.weeks.from_now, 1.year.from_now)

    listing['user_id'] = uids.sample

    Listing.create(listing)
  end
end

mateo = User.create(first_name: 'Mateo', last_name: 'Lazo', email: 'mateo@email.com', password: 'Mateo1', password_confirmation: 'Mateo1', role: 'editor')
freida = User.create(first_name: 'Freida', last_name: 'Gray', email: 'freida@email.com', password: 'Freida1', password_confirmation: 'Freida1', role: 'admin')
