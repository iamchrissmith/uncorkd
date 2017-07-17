require 'rails_helper'

RSpec.feature 'Managers can add a wine to their venue' do
  let(:wine) { create(:wine) }

  context 'when logged in as a manager' do
    let(:manager) { create(:user, :as_manager) }
    let!(:venue) { create(:venue, managers: [manager]) }

    it 'manager can click "Add to Venue" and the wine shows in the venue wines list' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(manager)

      visit wine_path(wine)

      expect(page).to have_link "Add to Venue", href: wine_add_to_venues_path(wine)

      click_on "Add to Venue"

      expect(page).to have_content "Select the venues where you would like to list #{wine.name}:"

      check venue.name

      click_on 'Add Wine to Venues'

      expect(current_path).to eq wine_path(wine)
      expect(page).to have_content "This wine has been successfully listed on your selected venues."
      expect(page).to have_content venue.name
    end
  end

  context 'when not logged in as a manager' do
    let(:member) { create(:user) }
    it "user cannot see add to venue link" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(member)

      visit wine_path(wine)

      expect(page).not_to have_content "Add to Venue"
    end

    it "guest cannot see add to venue link" do
      visit wine_path(wine)

      expect(page).not_to have_content "Add to Venue"
    end
  end
end
