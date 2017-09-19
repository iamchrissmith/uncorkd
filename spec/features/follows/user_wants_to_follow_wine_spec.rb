require 'rails_helper'

RSpec.feature 'user wants to follow a wine' do
  before(:each) do
    @user = create(:user)
    @wine = create(:wine, code: "olmaia-cabernet-di-toscana", name: "Olmaia Cabernet di Toscana")
  end
  context 'when logged in as a member' do
    it "member can follow a wine" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit wines_path

      expect(current_path).to eq("/wines")

      click_on(@wine.name)

      expect(current_path).to eq(wine_path(@wine.code))
      expect(page).to have_link("Follow Wine")

      click_on("Follow Wine")
      expect(current_path).to eq(wine_path(@wine))

      visit wine_path(@wine.code)

      expect(page).to have_link("Unfollow Wine")
      expect(@user.follows.first.target).to eq(@wine)
    end
  end
  context "when not logged in" do
    it "guest cannot see wine follow link" do
      visit wines_path(@wine)

      expect(page).to have_content(@wine.name)
      click_on(@wine.name)

      expect(current_path).to eq(wine_path(@wine.code))
      expect(page).not_to have_link("Follow Wine")
    end
  end
end
