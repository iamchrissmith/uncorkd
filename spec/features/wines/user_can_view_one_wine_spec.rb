require 'rails_helper'

RSpec.feature 'User can see one wine' do
  context 'without being logged in' do
    it 'guest can view a single wine\'s details' do
      wine = create(:wine, code: "olmaia-cabernet-di-toscana", name: "Olmaia Cabernet di Toscana")
      visit wines_path
      click_on wine.name

      expect(current_path).to eq wine_path(wine.code)
      expect(page).to have_content(wine.name)
      expect(page).to have_content("Vintage: ")
      expect(page).to have_content("Varietal: Cabernet Sauvignon")
      expect(page).to have_content("Vineyard: Col D Orcia")
      expect(page).to have_content("Varietal: Cabernet Sauvignon")
      expect(page).to have_content("Rating: ")
      expect(page).to have_content("Price: ")
    end
  end
end
