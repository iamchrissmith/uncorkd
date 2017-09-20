require 'rails_helper'

RSpec.feature "Managers can see a list of their venues" do
  context "when logged in as a manager" do
    let(:manager) { create(:user, :as_manager) }
    let!(:venues) { create_list(:venue, 3, managers: [manager]) }
    let!(:other_venues) { create_list(:venue, 2) }
    it "Managers see a list of their venues" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(manager)

      visit manager_venues_path

      html_venues = page.all('.venue')

      expect(html_venues.count).to eq 3

      expect(html_venues[0]).to have_link(venues.first.name, href: manager_venue_path(venues.first))
      expect(html_venues[0]).to have_content(venues.first.street_address)
      expect(html_venues[0]).to have_content(venues.first.city)
      expect(html_venues[0]).to have_content(venues.first.state)
      expect(html_venues[0]).to have_content(venues.first.zip)

      other_venues.each do |not_my_venue|
        expect(page).not_to have_link(not_my_venue.name, href: venue_path(not_my_venue))
      end
    end
  end

  context "when not logged in as a manager" do
    context "as a guest" do
      it "redirects the guest to the homepage with a message" do
        visit manager_venues_path

        expect(current_path).to eq root_path
        # expect(page).to have_content("You do not have permission to access this page.")
      end
    end
    context "as a member" do
      let(:member) { create(:user) }
      it "redirect the member to the homepage with a message" do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(member)

        visit manager_venues_path

        expect(current_path).to eq users_profile_path
        # expect(page).to have_content("You do not have permission to access this page.")
      end
    end
  end
end
