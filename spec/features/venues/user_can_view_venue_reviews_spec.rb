require 'rails_helper'

RSpec.feature 'Guest can view a single venues' do
  let!(:venues) { create_list(:venue, 2) }
  let!(:user) { create(:user) }
  context 'without being logged in' do
    it 'guest can view a single venue\'s details' do
      venues.each {|venue| venue.reviews.create(
        user_id: user.id,
        rating: 3,
        description: Faker::Hipster.sentence
        )}
      visit root_path

      within '.right' do
        click_on 'Venues'
      end

      expect(current_path).to eq venues_path

      click_on venues.first.name

      expect(current_path).to eq venue_path(venues.first)
      expect(page).to have_content venues.first.name
      expect(page).to have_content(venues.first.street_address)
      expect(page).to have_content(venues.first.city)
      expect(page).to have_content(venues.first.state)
      expect(page).to have_content(venues.first.zip)

      expect(page).to have_css("#map")
    end
  end
end
