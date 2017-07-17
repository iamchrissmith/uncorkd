require 'rails_helper'

RSpec.describe UserVenue, type: :model do
  context "relationships" do
    it "belongs to user" do
      user_venue = create(:user_venue)

      expect(user_venue).to respond_to(:manager)
    end

    it "belongs to venue" do
      user_venue = create(:user_venue)

      expect(user_venue).to respond_to(:venue)
    end
  end
end
