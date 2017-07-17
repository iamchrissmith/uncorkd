require 'rails_helper'

RSpec.feature "Managers can edit venues" do
  context "when logged in as a manager" do
    let(:manager) { create(:user, :as_manager) }
    it "Manager can edit a venue" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(manager)
      venue = manager.venues.create!(
                    name: "Bistro for the Plebs",
                    street_address: "123 Hollywood Pl",
                    city: "Hollywoooood",
                    state: "California",
                    zip: "90123",
                    latitude: "123.1111",
                    longitude: "124.111")

      visit root_path

      expect(current_path).to eq(user_path(manager))

      click_on "My Venues"

      expect(current_path).to eq(manager_venues_path)

      click_on "Bistro for the Plebs"

      expect(current_path).to eq(manager_venue_path(venue))

      click_on "Edit"

      expect(current_path).to eq(edit_manager_venue_path(venue))

      fill_in "Name", with: "Bistro for the Stars"

      click_button "Update Venue"

      expect(page).to have_content("Bistro for the Stars")
    end

    it "Manager cannot edit others venues" do
      manager_1 = create(:user, :as_manager)
      manager_2 = create(:user, :as_manager)
      venue = manager_2.venues.create(name: "Bistro for the Plebs",
                                      street_address: "123 Hollywood Pl",
                                      city: "Hollywoooood",
                                      state: "California",
                                      zip: "90123",
                                      latitude: "123.1111",
                                      longitude: "124.111")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(manager_1)

      visit manager_venues_path

      expect(page).not_to have_content("#{venue.name}")

      visit manager_venue_path(venue)

      expect(current_path).to eq(manager_venues_path)
      expect(page).to have_content("You do not have permission to access this page")
    end
  end

  context "when not logged in as a manager" do
    context "as a guest" do
      it "guests cannot see venue creation link" do
        venue = create(:venue)
        visit venue_path(venue)

        expect(page).not_to have_link "Edit Venue", href: edit_manager_venue_path(venue)
      end

      it "redirects the guest to the homepage with a message" do
        venue = create(:venue)
        visit manager_venue_path(venue)

        expect(current_path).to eq root_path
        expect(page).to have_content("You do not have permission to access this page.")
      end
    end

    context "as a member" do
      let(:member) { create(:user) }
      it "user cannot see venue edit link" do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(member)
        venue = create(:venue)

        visit venue_path(venue)

        expect(page).not_to have_link "Edit Venue", href: edit_manager_venue_path(venue)
      end

      it "redirects the member to the homepage with a message" do
        venue = create(:venue)

        visit manager_venue_path(venue)

        expect(page).to have_content("You do not have permission to access this page.")
      end
    end
  end
end
