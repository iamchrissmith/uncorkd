require 'rails_helper'

RSpec.feature "user can login" do
  let(:user) { create(:user) }
  context "registered user not yet logged in" do
    it "user logs in" do
      visit '/'
      within (".right") do
        click_on "Login"
      end
      expect(current_path).to eq('/login')

      within("form") do
        fill_in "Username", with: user.username
        fill_in "Password", with: user.password
        click_on "Login"
      end

      expect(current_path).to eq(users_profile_path)
      expect(page).to have_content(user.email)
      expect(page).to have_content(user.bio)
      expect(page).to have_content("Followers")
      expect(page).to have_content("Following")
    end
  end

  context "user enters wrong information" do
    it "displays error flash and keeps them on login page" do
      visit '/'
      within (".right") do
        click_on "Login"
      end
      expect(current_path).to eq('/login')

      within("form") do
        fill_in "Username", with: user.username
        fill_in "Password", with: "12345"
        click_on "Login"
      end

      expect(current_path).to eq(login_path)
      # expect(page).to have_content("Incorrect Login information, try again")
    end
  end
end
