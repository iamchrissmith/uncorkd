require 'rails_helper'

RSpec.feature "user can view profile" do
  context "when logged in" do
    let(:user) { create(:user) }
    it "user sees their profile" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit '/'

      expect(page).to have_content("Hello, #{user.first_name} #{user.last_name}")
      expect(page).to have_content("Logout")
      expect(page).not_to have_content("Login")

      click_on "#{user.first_name} #{user.last_name}"

      expect(current_path).to eq(users_profile_path)
      expect(page).to have_content(user.email)
      expect(page).to have_content(user.bio)
      expect(page).to have_content("Followers")
      expect(page).to have_content("Following")
      expect(page).to have_content("Badges")
      expect(page).to have_content("News Feed")
      expect(page).to have_content(user.username)
    end

    it "user can see their followed wines" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      wine_1, wine_2, wine_3 = create_list(:wine, 3)
      create(:follow, user: user, target: wine_2)
      create(:follow, user: user, target: wine_3)

      visit '/'

      expect(page).to have_content("Wines You Follow")
      expect(page).to have_content(wine_2.name)
      expect(page).to have_content(wine_3.name)
      expect(page).to_not have_content(wine_1.name)
    end

    it "user can see their followed venues" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      venue_1, venue_2, venue_3 = create_list(:venue, 3)
      create(:follow, user: user, target: venue_2)
      create(:follow, user: user, target: venue_3)

      visit '/'

      expect(page).to have_content("Venues You Follow")
      expect(page).to have_content(venue_2.name)
      expect(page).to have_content(venue_3.name)
      expect(page).to_not have_content(venue_1.name)
    end
  end

  context "when not logged in" do
    let(:user) { create(:user) }
    it "user is redirected to login" do
      visit users_profile_path

      expect(current_path).to eq(login_path)
    end
  end
end
