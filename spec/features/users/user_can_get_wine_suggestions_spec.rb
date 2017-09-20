require 'rails_helper'

RSpec.feature "User visits wine suggestion page" do
  it "fills out occasion info and receives 3 suggestions" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/new_suggestion"

    select "Celebration", :from => "occasion"
    select "Summer", :from => "season"
    select "Cheese and Crackers", :from => "food"
    click "Submit"

    expect(page).to have_css(".wine_suggestion", count: 3)
  end
end
