require 'rails_helper'

RSpec.feature "Admin deletes venue" do
  it "venue is deleted" do
    admin = create(:user, role: "admin")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    venue_1, venue_2 = create_list(:venue, 2)

    visit '/'

    click_on("Manage Venues")
    within(".venue-#{venue_1.id}") do
      click_on "Delete"
    end
    expect(page).to_not have_content(venue_1.name)
    expect(page).to have_content(venue_2.name)
  end
end
