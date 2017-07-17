require 'rails_helper'

RSpec.describe Venue, type: :model do
  context 'geocoding' do
    it 'has a lat/long' do
      venue = create(:venue)

      expect(venue).to respond_to(:latitude)
      expect(venue.latitude).to be_a Float
      expect(venue).to respond_to(:longitude)
      expect(venue.longitude).to be_a Float
    end

    it "can return a .full_address" do
      address = {
        street_address: "321 Address",
        city: "Not Denver",
        state: "WY",
        zip: "82609"
      }
      venue = create(:venue, address)

      expect(venue).to respond_to(:full_address)

      our_address = "#{address[:street_address]} #{address[:city]}, #{address[:state]} #{address[:zip]}"

      expect(venue.full_address).to eq our_address
    end
  end

  context "relationships" do
    it "has many user_venues" do
      venue = create(:venue)

      expect(venue).to respond_to(:user_venues)
    end

    it "has many users" do
      venue = create(:venue)

      expect(venue).to respond_to(:managers)
    end

    it 'has many venue_wines' do
      venue = create(:venue)

      expect(venue).to respond_to(:venue_wines)
    end

    it 'has many wines' do
      venue = create(:venue)

      expect(venue).to respond_to(:wines)
    end
  end
end
