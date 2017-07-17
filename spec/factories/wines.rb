FactoryGirl.define do
  factory :wine do
    varietal "MyString"
    vintage "MyString"
    vineyard "MyString"
    rating 98
    description "TASTY"
    sequence(:name) { |n| "name #{n}"}
  end
end
