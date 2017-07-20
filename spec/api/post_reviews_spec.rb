require 'rails_helper'
=begin
As a user
When I navigate to the wines or venues #show page
I should see a button/link to create API review
And when I click on "Create API Review"
I'll be taken to a new_api_review form
And when I fill in review details (description & rating)
And I click_on submit
I should see a successful message
And I should see all the reviews for that objects (wine/venue#show)
=end
describe "POST /api/v1/reviews" do
  context "POST a wine review" do
    let(:user) { create{:user) }
    let(:wine) { create(:wine) }
    it "posts review via API" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit wine_path(wine)

      expect(page).to have_link("Create Review via API", href: new_api_v1_review)

      click_link "Create Review via API"

      expect(current_path).to eq(new_api_v1_review)
      expect(page).to have_link()

      fill_in "Description", with: "Had better"
      fill_in "Rating", with: 4
      click_button "Create Review"
      

    end



  end
  context "POST a venue review" do
    it "posts review via API" do

    end
  end

end