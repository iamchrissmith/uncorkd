require 'rails_helper'

RSpec.feature "inactive users try to log in" do
  it "is not able to login and sees a flash message" do
    user = create(:user, status: "inactive")
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

    expect(current_path).to eq(login_path)
    expect(page).to_not have_content("Hello #{user.first_name} #{user.last_name}")
    expect(page).to have_content("Login")
    expect(page).to_not have_content("Logout")
  end
end
