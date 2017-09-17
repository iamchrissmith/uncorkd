require 'rails_helper'

RSpec.feature "Admin deletes wine" do
  it "wine is deleted" do
    admin = create(:user, role: "admin")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    wine_1, wine_2 = create_list(:wine, 2)

    visit '/'

    click_on("Manage Wines")
    within(".wine-#{wine_1.id}") do
      click_on "Delete"
    end
    expect(page).to_not have_content(wine_1.name)
    expect(page).to have_content(wine_2.name)
  end
end
