require 'rails_helper'

RSpec.feature 'Guest can view a list of all wines' do

  context 'without being logged in' do
    it 'guest can view a list of wines' do
      visit root_path

      within '.right' do
        click_on 'Wines'
      end

      expect(current_path).to eq wines_path

      html_wines = page.all('.wine')
      expect(html_wines.count).to eq 30

      expect(html_wines[0]).to have_link("Guigal Cotes Rouge")
      expect(html_wines[0]).to have_content("Varietal")
      expect(html_wines[0]).to have_content("Vintage")
      expect(html_wines[0]).to have_content("Vineyard")
      expect(html_wines[0]).to have_content("Rating")
      expect(html_wines[0]).to have_content("Price")

      expect(page).to have_css '.next_page'
    end

    it 'guest can view second page of wines' do
      visit root_path

      within '.right' do
        click_on 'Wines'
      end

      within '.pagination .next_page' do
        click_link
      end

      expect(current_path).to eq wines_path

      html_wines = page.all('.wine')
      expect(html_wines.count).to eq 30

      expect(html_wines[3]).to have_link("Channing Daughters Pinot Grigio Long Island Ramato")
      expect(html_wines[3]).to have_content("Varietal")
      expect(html_wines[3]).to have_content("Vintage")
      expect(html_wines[3]).to have_content("Vineyard")
      expect(html_wines[3]).to have_content("Rating")
      expect(html_wines[3]).to have_content("Price")

      expect(page).to have_css '.previous_page'
    end
  end
end
