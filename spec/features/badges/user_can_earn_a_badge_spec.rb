require 'rails_helper'

RSpec.feature "User can earn a badge" do
  context "when logged in" do
    context "after leaving 10 reviews" do
      let(:user) { create(:user) }
      let!(:wine) { create(:wine, name: "Olmaia Cabernet di Toscana", code: "olmaia-cabernet-di-toscana") }
      it "you earn all star performer badge and it appears on your profile" do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        badge = create(:badge)
        10.times do
          counter = 1

          visit wines_path

          click_link wine.name

          click_link "Review"

          fill_in "Description", with: "Nice tannins"
          fill_in "Rating", with: counter

          click_button "Create Review"

          counter += 1
        end

        visit users_profile_path(user)

        expect(page).to have_content(badge.name)
      end
    end
  end
end
