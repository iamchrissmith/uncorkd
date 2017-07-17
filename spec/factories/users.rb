FactoryGirl.define do
  factory :user do
    first_name "MyFirstName"
    last_name "MyLastName"
    email "MyEmail@email.com"
    bio "Mybio blah blah"
    phone_number "12310041041"
    password "password"
    role 0

    sequence(:username) { |n| "username#{n}" }
  end

  trait :as_manager do
    role 1
  end

  trait :as_admin do
    role 2
  end
end
