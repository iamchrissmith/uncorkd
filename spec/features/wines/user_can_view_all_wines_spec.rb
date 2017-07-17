require 'rails_helper'

RSpec.feature 'Guest can view a list of all wines' do

  context 'without being logged in' do
    let!(:wines) { create_list(:wine, 35) }

    it 'guest can view a list of wines' do
      visit root_path

      within '.right' do
        click_on 'Wines'
      end

      expect(current_path).to eq wines_path

      html_wines = page.all('.wine')
      expect(html_wines.count).to eq 30

      expect(html_wines[0]).to have_link(wines.first.name, href: wine_path(wines.first))
      expect(html_wines[0]).to have_content(wines.first.varietal)
      expect(html_wines[0]).to have_content(wines.first.vintage)
      expect(html_wines[0]).to have_content(wines.first.vineyard)
      expect(html_wines[0]).to have_content(wines.first.rating)
      expect(html_wines[0]).to have_content(wines.first.description)

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
      expect(html_wines.count).to eq 5

      expect(html_wines[4]).to have_link(wines.last.name, href: wine_path(wines.last))
      expect(html_wines[4]).to have_content(wines.last.varietal)
      expect(html_wines[4]).to have_content(wines.last.vintage)
      expect(html_wines[4]).to have_content(wines.last.vineyard)
      expect(html_wines[4]).to have_content(wines.last.rating)
      expect(html_wines[4]).to have_content(wines.last.description)

      expect(page).to have_css '.previous_page'
    end
  end
end
