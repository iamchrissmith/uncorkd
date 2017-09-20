FactoryGirl.define do
  factory :wine do
    sequence(:code) {|n| "red-wine-200#{n}"}
    sequence(:name) { |n| "name #{n}"}
  end

  trait :with_review do
    after(:create) do |wine|
      create(:review, reviewable: wine)
    end
  end
end
