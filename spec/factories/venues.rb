FactoryGirl.define do
  factory :venue do
    street_address "123 Address"
    city "Denver"
    state "CO"
    zip "01234"

    sequence(:name) { |n| "Place #{n}" }
  end
end
