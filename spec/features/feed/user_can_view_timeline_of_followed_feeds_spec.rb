require 'rails_helper'

RSpec.feature "user wants to view timeline of followed feeds" do

  context 'when logged in as a member' do
    context 'when there is no activity' do
      let(:user) { create(:user) }
      it 'the user sees that they have no activity' do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        allow_any_instance_of(User).to receive(:news_feed).and_return([])

        visit users_profile_path

        expect(page).to have_content "News Feed"
        expect(page).to have_content "No activity."
      end
    end
    context "when a venue they follow gets followed" do
      let!(:user1) { create(:user) }
      let!(:user2) { create(:user) }
      let!(:target) { create(:venue) }
      it "the user sees can see another's follow" do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)
        visit venue_path(target)
        click_on "Follow Venue"


        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user2)
        visit venue_path(target)
        click_on "Follow Venue"


        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

        visit users_profile_path

        expect(page).to have_content "News Feed"
        expect(page).to have_content "#{user2.first_name} #{user2.last_name} followed #{target.name}"
      end
    end
  end
end
