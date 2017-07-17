require 'rails_helper'

RSpec.feature 'User can see one wine' do
  let!(:wines) { create_list(:wine, 2) }
  context 'without being logged in' do
    it 'guest can view a single wine\'s details' do
      visit root_path

      within '.right' do
        click_on 'Wines'
      end

      expect(current_path).to eq wines_path

      click_on wines.first.name

      expect(current_path).to eq wine_path(wines.first)
      expect(page).to have_content wines.first.name
      expect(page).to have_content(wines.first.varietal)
      expect(page).to have_content(wines.first.vintage)
      expect(page).to have_content(wines.first.vineyard)
      expect(page).to have_content(wines.first.rating)
      expect(page).to have_content(wines.first.description)
      expect(page).not_to have_content(wines.last.name)
    end
  end
end
