require 'rails_helper'

RSpec.describe Wine, type: :model do
  describe "relationships" do
    it 'belongs_to wine' do
      venue = create(:venue_wine)

      expect(venue).to respond_to(:wine)
    end

    it 'belongs_to venue' do
      venue = create(:venue_wine)

      expect(venue).to respond_to(:venue)
    end
  end

  context "Factory" do
    it "should be a wine_venue" do
      expect(create(:venue_wine)).to be_a(VenueWine)
    end
  end
end
