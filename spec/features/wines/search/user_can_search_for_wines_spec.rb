require 'rails_helper'

RSpec.feature 'User searches for wine' do
  context 'when the wine already exists in the system' do
    let!(:wine1) { create(:wine, name: 'Pinot Noir Red') } # name 1
    let!(:wine2) { create(:wine, name: "Cabernet blanc White") }
    let!(:wine3) { create(:wine, name: "Cabernet Sauvignon Red") }

    context 'when the user enters the full wine name' do
      scenario 'user sees matching wine' do
        visit wines_path

        expect(page).to have_content "Search for a wine:"
        form_action = find('#search_form')['action']
        expect(form_action).to eq wines_path
        expect(page).to have_content wine1.name
        expect(page).to have_content wine2.name
        expect(page).to have_content wine3.name

        fill_in 'Search', with: wine1.name

        click_button 'Search'

        expect(current_path).to eq wines_path
        expect(page).to have_content "You searched for: #{wine1.name}"
        within ('.wines') do
          expect(page).to have_content wine1.name
          expect(page).not_to have_content wine2.name
          expect(page).not_to have_content wine3.name
        end
      end
    end

    context 'when the users enters a trigram partial' do
      scenario 'user sees matching wines' do
        visit wines_path

        expect(page).to have_content "Search for a wine:"
        expect(page).to have_content wine1.name
        expect(page).to have_content wine2.name
        expect(page).to have_content wine3.name

        fill_in 'Search', with: 'Red'

        click_button 'Search'

        expect(current_path).to eq wines_path
        within ('.wines') do
          expect(page).to have_content wine1.name
          expect(page).not_to have_content wine2.name
          expect(page).to have_content wine3.name
        end
      end
    end
  end

  context 'when the wine has not been added yet' do
    it 'shows the users the matching wine from Wines.com'
  end
end
