require 'rails_helper'

RSpec.feature "Admin edits role of user" do
  it "can change any user to any role" do
    admin = create(:user, role: "admin")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    user_1 = create(:user)

    visit '/'
    expect(page).to have_content("Admin Dashboard")

    click_on("Manage Users")
    within(".user-#{user_1.id}") do
      within(".role") {expect(page).to have_content("member")}
      click_on "Make Manager"
    end
    within(".user-#{user_1.id}") do
      within(".role") {expect(page).to have_content("manager")}
      within(".role") {expect(page).to_not have_content("member")}
      click_on "Make Admin"
    end
    within(".user-#{user_1.id}") do
      within(".role") {expect(page).to have_content("admin")}
      within(".role") {expect(page).to_not have_content("manager")}
      click_on "Make Member"
    end
    within(".user-#{user_1.id}") do
      within(".role") {expect(page).to have_content("member")}
      within(".role") {expect(page).to_not have_content("manager")}
      within(".role") {expect(page).to_not have_content("admin")}
    end
  end
end
