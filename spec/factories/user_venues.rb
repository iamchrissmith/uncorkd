FactoryGirl.define do
  factory :user_venue do
    venue
    manager { create(:user, :as_manager) }
  end
end
