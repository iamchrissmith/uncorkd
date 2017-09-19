require 'rails_helper'

RSpec.describe "User Can Sign In And Out Through Facebook" do
  it "Sees that home Page with User name" do
    # VCR.use_cassette("features/user_sees_home_page") do
     user = create(:user)

     OmniAuth.config.test_mode = true
     OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
       provider: "facebook",
       uid: "1234567890",
       info: {
         email: user.email,
         first_name: user.first_name,
         last_name: user.last_name
       }})

     visit "/"

     within (".right") do
       click_on "Login"
     end
     
     click_on "Sign in with Facebook"

     expect(current_path).to eq users_profile_path
     expect(page).to have_content "Hello, #{user.name}"
     expect(page).to_not have_content "Login"
  end
end
