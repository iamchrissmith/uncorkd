require 'rails_helper'

RSpec.feature "Admin deactivates and reactivates user" do
  it "user is deactivated" do
    admin = create(:user, role: "admin")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    user_1, user_2 = create_list(:user, 2)

    visit '/'

    click_on("Manage Users")
    # binding.pry
    within(".user-#{user_1.id}") do
      click_on "Deactivate"
    end
    within(".user-#{user_1.id}") do
      expect(page).to have_content("inactive")
    end
    within(".user-#{user_1.id}") do
      click_on "Reactivate"
    end
    within(".user-#{user_1.id}") do
      expect(page).to have_content("active")
      expect(page).to_not have_content("inactive")
    end
  end
end
