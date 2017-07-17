require 'rails_helper'

RSpec.feature "Managers can create venues" do
  context "when logged in as a manager" do
    let(:manager) { create(:user, :as_manager) }
    it "Manager can create a venue" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(manager)

      visit root_path

      expect(current_path).to eq user_path(manager)

      click_link "Add Venue"

      expect(current_path).to eq new_manager_venue_path

      fill_in "Name", with: "My Venue"
      fill_in "Street address", with: "123 Address"
      fill_in "City", with: "Denver"
      fill_in "State", with: "CO"
      fill_in "Zip", with: "80203"

      click_button "Create Venue"

      venue = Venue.last

      expect(current_path).to eq manager_venue_path(venue)

      expect(venue.managers).to include(manager)

      expect(page).to have_content("Venue Successfully Created")
      expect(page).to have_link("Edit", href: edit_manager_venue_path(venue))
    end
  end

  context "when not logged in as a manager" do
    context "as a guest" do
      it "guests cannot see venue creation link" do
        visit root_path

        expect(page).not_to have_link "Add Venue", href: new_manager_venue_path
      end

      it "redirects the guest to the homepage with a message" do
        visit new_manager_venue_path

        expect(current_path).to eq root_path
        expect(page).to have_content("You do not have permission to access this page.")
      end
    end
    context "as a member" do
      let(:member) { create(:user) }
      it "user cannot see venue creation link" do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(member)

        visit root_path

        expect(page).not_to have_link "Add Venue", href: new_manager_venue_path
      end

      it "redirects the member to the homepage with a message" do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(member)

        visit new_manager_venue_path

        expect(current_path).to eq root_path
        expect(page).to have_content("You do not have permission to access this page.")
      end
    end
  end
end
