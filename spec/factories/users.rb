FactoryGirl.define do
  factory :user do
    sequence :first_name {|n| "MyFirstName#{n}"}
    sequence :last_name {|n| "MyLastName#{n}"}
    email "MyEmail@email.com"
    bio "Mybio blah blah"
    country_code "1"
    phone_number "12310041041"
    password "password"
    role 0
    status 0
    uid "1234567890"

    sequence(:username) { |n| "username#{n}" }
  end

  trait :as_manager do
    role 1
  end

  trait :as_admin do
    role 2
  end
end
