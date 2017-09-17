User.destroy_all
Venue.destroy_all
Wine.destroy_all
Badge.destroy_all
Review.destroy_all
UserBadge.destroy_all

def create_venues
  venues = [
    ["Jerri's Tobacco Shop and Fine Wines", "500 16th Street, #136", "Denver", "Colorado", "80202", "39.7436737", "-104.990995"],
    ["Wine Dispensary", "435 West Colfax Avenue, #101", "Denver", "Colorado", "80204", "39.7403151", "-104.9938457"],
    ["The Greedy Hamster", "323 14th Street", "Denver", "Colorado", "80202", "39.7411553", "-104.9914505"],
    ["Pints Pub", "221 West 13th Avenue", "Denver", "Colorado", "80204", "39.7369726", "-104.9908527"],
    ["CY Steak", "1222 Glenarm Place", "Denver", "Colorado", "80202", "39.7404147", "-104.9943705"],
    ["Yard House", "1555 Court Place", "Denver", "Colorado", "80202", "39.7429798", "-104.9895691"],
    ["Capitol Hill Tavern", "1225 Logan Street", "Denver", "Colorado", "80202", "39.735573", "-104.982647"],
    ["Altitude Restaurant", "650 15th Street", "Denver", "Colorado", "80202", "39.7434362", "-104.9935893"],
    ["Cuba Cuba Cafe & Bar", "1173 Delaware Street", "Denver", "Colorado", "80204", "39.735088", "-104.993191"],
    ["5280 Burger Bar", "500 16th Street, #160", "Denver", "Colorado", "80202", "39.7432386", "-104.9909842"],
    ["Maggiano's Little Italy", "500 16th Street, Suite 150", "Denver", "Colorado", "80202", "39.7435013", "-104.9908943"]]

  venues.each do |venue|
    Venue.create!(name: venue[0],
                 street_address: venue[1],
                 city: venue[2],
                 state: venue[3],
                 zip: venue[4],
                 latitude: venue[5],
                 longitude: venue[6])
    puts "Venue #{venue[0]} created"
  end
end

def create_wines
  wines = [
    ["Fallows Red", "A dark wine with strong flavours", 98, "Pinot Noir", "1651", "Fallows Yard"]
    ]
  wines.each do |wine|
    Wine.create!(name: wine[0],
                 description: wine[1],
                 rating: wine[2],
                 varietal: wine[3],
                 vintage: wine[4],
                 vineyard: wine[5])
    puts "Wine #{wine[0]} created"
  end
end

def create_fake_wines
  year = (1800..2017).to_a
  type = ["Red", "White", "Rose", "Champagne", "Rotgut", "Dessert Wine"]
  100.times do
    wine = Wine.new
    wine.name = "#{Faker::GameOfThrones.character} #{type.sample}"
    wine.description = Faker::VentureBros.quote
    wine.rating = Faker::PhoneNumber.subscriber_number(2)
    wine.varietal = Faker::GameOfThrones.house
    wine.vintage = year.sample
    wine.vineyard = Faker::GameOfThrones.city
    wine.save
    puts "Wine #{wine.name} created"
  end
end

def wine_sample
  first = Wine.first.id
  last = Wine.last.id
  wines = (first..last).to_a
  wines.sample
end

def venue_sample
  first = Venue.first.id
  last = Venue.last.id
  venues = (first..last).to_a
  venues.sample
end

def rating
  batch = (1..10).to_a
  batch.sample
end

def create_wine_review_for_user(user)
  wine =  Wine.find(wine_sample)
  wine.reviews.create(
                      user_id: user.id,
                      rating: rating,
                      description: Faker::Hipster.sentence
                      )
end

def create_venue_review_for_user(user)
  venue = Venue.find(venue_sample)
  venue.reviews.create(
                      user_id: user.id,
                      rating: rating,
                      description: Faker::Hipster.sentence
                      )
end

def create_users
  users = [
    ["Doug", "Miller", "dmiller", "doug@dmail.com", "I like big trucks and I like fine wine", "303-111-2222", "trucks4lyfe", '1']
    ]
  users.each do |user|
    User.create!(first_name: user[0],
                 last_name: user[1],
                 username: user[2],
                 email: user[3],
                 bio: user[4],
                 phone_number: user[5],
                 password: user[6],
                 country_code: user[7])
    puts "User #{user[0]} #{user[1]} created"
  end
end

def create_fake_users
  1000.times do
    user = User.new
    user.first_name = Faker::Name.first_name
    user.last_name = Faker::Name.last_name
    user.username = Faker::Internet.user_name("#{user.first_name} #{user.last_name}", %w(. _ -))
    user.email = Faker::Internet.email
    user.bio = Faker::ChuckNorris.fact
    user.phone_number = Faker::PhoneNumber.phone_number
    user.password = "password"
    user.country_code = '1'
    user.save
    puts "User #{user.first_name} #{user.last_name} created"
    3.times do
      create_venue_review_for_user(user)
      create_wine_review_for_user(user)
    end
    puts "6 Reviews created for #{user.username}"
  end
end

def create_managers
  users = [
    ["Dave", "Miller", "davemiller", "dave@davemail.com", "I like fine wine", "303-111-2222", "wine4lyfe", 1]
    ]
  users.each do |user|
    User.create!(first_name: user[0],
                 last_name: user[1],
                 username: user[2],
                 email: user[3],
                 bio: user[4],
                 phone_number: user[5],
                 password: user[6],
                 role: 1,
                 country_code: '1')
    puts "Manager #{user[0]} #{user[1]} created"
  end
end

def create_fake_managers
  50.times do
    user = User.new
    user.first_name = Faker::Name.first_name
    user.last_name = Faker::Name.last_name
    user.username = Faker::Internet.user_name("#{user.first_name} #{user.last_name}", %w(. _ -))
    user.email = Faker::Internet.email
    user.phone_number = Faker::PhoneNumber.phone_number
    user.password = "password"
    user.role = 1
    user.country_code = '1'
    user.save
    puts "Manager #{user.first_name} #{user.last_name} created"
  end
end

def create_admin
  User.create(first_name: 'Admin',
              last_name: 'Of The Site',
              email: 'admin@admin.com',
              username: 'admin',
              phone_number: '303-231-7026',
              country_code: '1',
              password: 'password',
              role: 2)
  puts "Created admin user"
end

def create_fake_venues
  type = ["Bistro", "Winery", "Bar", "Pub", "Club", "Speak Easy"]
  50.times do
    venue = Venue.new
    venue.name = "#{Faker::Witcher.character} #{type.sample}"
    venue.street_address = Faker::Address.street_address
    venue.state = Faker::Address.state
    venue.city = Faker::Address.city
    venue.zip = Faker::Address.zip
    venue.latitude = Faker::Address.latitude
    venue.longitude = Faker::Address.longitude
    venue.save
    puts "Venue #{venue.name} created"
  end
end

def create_badge
  Badge.create(name: "All Star Reviewer", description: "You are a contributing community member. You have given at least 10 reviews.")
end

create_users
# create_managers
create_fake_venues
create_venues
create_fake_wines
create_wines
create_fake_users
create_fake_managers
create_admin
create_badge
