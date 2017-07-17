User.destroy_all
Venue.destroy_all
Wine.destroy_all

def create_users
  users = [
    ["Doug", "Miller", "dmiller", "doug@dmail.com", "I like big trucks and I like fine wine", "303-111-2222", "trucks4lyfe"]
    ]
  users.each do |user|
    User.create!(first_name: user[0],
                 last_name: user[1],
                 username: user[2],
                 email: user[3],
                 bio: user[4],
                 phone_number: user[5],
                 password: user[6])
    puts "User #{user[0]} #{user[1]} created"
  end
end

def create_fake_users
  100.times do
    user = User.new
    user.first_name = Faker::Name.first_name
    user.last_name = Faker::Name.last_name
    user.username = Faker::Internet.user_name("#{user.first_name} #{user.last_name}", %w(. _ -))
    user.email = Faker::Internet.email
    user.bio = Faker::Witcher.quote
    user.phone_number = Faker::PhoneNumber.phone_number
    user.password = Faker::Internet.password
    user.save
    puts "User #{user.first_name} #{user.last_name} created"
  end
end

def create_managers
  users = [
    ["Dave", "Miller", "davemiller", "dave@davemail.com", "I like fine wine", "303-111-2222", "wine4lyfe"]
    ]
  users.each do |user|
    User.create!(first_name: user[0],
                 last_name: user[1],
                 username: user[2],
                 email: user[3],
                 bio: user[4],
                 phone_number: user[5],
                 password: user[6],
                 role: 1)
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
    user.bio = Faker::Witcher.quote
    user.phone_number = Faker::PhoneNumber.phone_number
    user.password = Faker::Internet.password
    user.role = 1
    user.save
    puts "Manager #{user.first_name} #{user.last_name} created"
  end
end

def create_admin
  User.create(first_name: 'Admin',
              last_name: 'Of The Site',
              email: 'admin@admin.com',
              password: 'password',
              role: 2)
  puts "Created admin user"
end

def create_venues
  venues = [
    ["Daves Bistro", "1200 David Street", "Davetown", "Davidson", "80001", "20.12", "122.40"]
    ]
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

def create_fake_venues
  type = ["Bistro", "Winery", "Bar", "Pub", "Club", "Speak Easy"]
  50.times do
    venue = Venue.new
    venue.name = "#{Faker::Witcher.character} #{type.sample}"
    venue.street_address = Faker::Address.street_address
    venue.state = Faker::Address.state
    venue.zip = Faker::Address.zip
    venue.latitude = Faker::Address.latitude
    venue.longitude = Faker::Address.longitude
    venue.save
    puts "Venue #{venue.name} created"
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
  type = ["Red", "White", "Rose", "Champagne", "Rotgut", "Dessert Wine"]
  100.times do
    wine = Wine.new
    wine.name = "#{Faker::GameOfThrones.character} #{type.sample}"
    wine.description = Faker::Witcher.quote
    wine.rating = Faker::PhoneNumber.subscriber_number(2)
    wine.varietal = Faker::GameOfThrones.house
    wine.vintage = Faker::PhoneNumber.subscriber_number(4)
    wine.vineyard = Faker::GameOfThrones.city
    wine.save
    puts "Wine #{wine.name} created"
  end
end

create_users
create_fake_users
create_managers
create_fake_managers
create_admin
create_venues
create_fake_venues
create_wines
create_fake_wines
