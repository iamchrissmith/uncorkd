require 'rails_helper'

RSpec.feature 'Guest can view a list of all venues' do
  let!(:venues) { create_list(:venue, 35) }

  context 'without being logged in' do
    it 'guest can view a list of venues' do
      visit root_path

      within '.right' do
        click_on 'Venues'
      end

      expect(current_path).to eq venues_path

      html_venues = page.all(".venue")
      expect(html_venues.count).to eq 30

      expect(html_venues[0]).to have_link(venues.first.name, href: venue_path(venues.first))
      expect(html_venues[0]).to have_content(venues.first.street_address)
      expect(html_venues[0]).to have_content(venues.first.city)
      expect(html_venues[0]).to have_content(venues.first.state)
      expect(html_venues[0]).to have_content(venues.first.zip)

      expect(page).to have_css '.next_page'
    end

    it 'guest can view second page of venues' do
      visit root_path

      within '.right' do
        click_on 'Venues'
      end

      within '.pagination .next_page' do
        click_link
      end

      expect(current_path).to eq venues_path

      html_venues = page.all('.venue')
      
      expect(html_venues.count).to eq 5
      expect(html_venues[4]).to have_link(venues.last.name, href: venue_path(venues.last))
      expect(html_venues[4]).to have_content(venues.last.street_address)
      expect(html_venues[4]).to have_content(venues.last.city)
      expect(html_venues[4]).to have_content(venues.last.state)
      expect(html_venues[4]).to have_content(venues.last.zip)

      expect(page).to have_css '.previous_page'
    end
  end
end
