require 'rails_helper'

RSpec.feature "user wants to review..." do
  context "a wine" do
    context "when logged in" do
      let(:user) { create(:user) }
      let!(:wine) { create_list(:wine, 3)}
      it "user can review wine in the DB" do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        test_wine = Wine.first

        visit wines_path
        page.assert_selector('.wine', :count => 3)

        within '.wines' do
          click_on test_wine.name
        end

        expect(current_path).to eq(wine_path(test_wine))

        click_link "Review"

        expect(current_path).to eq(new_users_review_path)
        fill_in "Description", with: "Nice tannins"
        fill_in "Rating", with: 9
        click_button "Create Review"
        # expect(page).to have_content("Review successfully submitted!")
        expect(current_path).to eq(wine_path(test_wine))
      end
    end

    context "when not logged in" do
      let!(:wine) { create(:wine)}
      it "user is redirected to login" do
          visit wine_path(wine)

          expect(page).not_to have_content("Review")
      end
    end
  end
  context "a venue" do
    context "when logged in" do
      let(:user) { create(:user) }
      let!(:venue) { create_list(:venue, 3)}
      it "user can review venue in the DB" do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        test_venue = Venue.first

        visit venues_path
        page.assert_selector('.venue', :count => 3)


        within '.venues' do
          click_on test_venue.name
        end

        expect(current_path).to eq(venue_path(test_venue))

        click_link "Review"

        expect(current_path).to eq(new_users_review_path)
        fill_in "Description", with: "Nice wines"
        fill_in "Rating", with: 9
        click_button "Create Review"
        # expect(page).to have_content("Review successfully submitted!")
        expected_review = test_venue.reviews.last.description

        expect(page).to have_content(expected_review)
        expect(current_path).to eq(venue_path(test_venue))
      end
    end

    context "when not logged in" do
      let!(:venue) { create(:venue)}
      it "user is redirected to login" do
        visit venue_path(venue)

        expect(page).not_to have_content("Review")
      end
    end
  end

end
