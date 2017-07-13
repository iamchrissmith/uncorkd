require 'rails_helper'

RSpec.feature "User can Edit Profile" do
  let(:user) { create(:user) }
  context "when logged in" do
    let(:new_info) {{
      first_name: "FN1",
      last_name: "LN1",
      username: "username1",
      email: "email@email.com1",
      phone_number: "123-456-7891",
      bio: "Consectetur adipiscing elit.",
      password:"abc123"}
    }

    it "user should be able to update all of their information" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit user_path(user)

      click_on "Edit Profile"

      expect(current_path).to eq edit_user_path(user)

      fill_in "First name", with: new_info[:first_name]
      fill_in "Last name", with: new_info[:last_name]
      fill_in "Username", with: new_info[:username]
      fill_in "Email", with: new_info[:email]
      fill_in "Phone number", with: new_info[:phone_number]
      fill_in "Biography", with: new_info[:bio]
      fill_in "Password", with: new_info[:password]

      click_on "Update User"

      user.reload

      expect(current_path).to eq user_path(user)
      expect(page).to have_content "Profile updated"
      expect(page).to have_content("Hello, #{new_info[:first_name]} #{new_info[:last_name]}")
      expect(page).to have_content(new_info[:email])
      expect(page).to have_content(new_info[:bio])
      expect(page).to have_content("Your Followers")
      expect(page).to have_content("Following")
    end

    it "user should be able to update their password" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit user_path(user)

      click_on "Edit Profile"

      expect(current_path).to eq edit_user_path(user)

      fill_in "Password", with: new_info[:password]

      click_on "Update User"

      user.reload

      expect(current_path).to eq user_path(user)
      expect(page).to have_content "Profile updated"
      expect(page).to have_content("Hello, #{user.first_name} #{user.last_name}")
      expect(page).to have_content(user.email)
      expect(page).to have_content(user.bio)
      expect(page).to have_content("Your Followers")
      expect(page).to have_content("Following")
    end
  end

  context "when not logged in" do
    it "user should be redirected to the login page" do
      visit edit_user_path(user)

      expect(current_path).to eq(login_path)
      expect(page).to have_content("You must be logged in to do this.")
    end
  end
end
