require 'rails_helper'

RSpec.describe Wine, type: :model do
  describe "validations" do
    context "invalid attributes" do
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:vintage) }
      it { should validate_presence_of(:rating) }
      it { should validate_uniqueness_of(:name) }
    end

    context "valid attributes" do
      it "is valid with a name, varietal, vintage, vineyard, description and rating" do
        wine = create(:wine)

        expect(wine).to be_valid
      end
    end

    context "relationships" do
      it 'has many venue_wines' do
        venue = create(:wine)

        expect(venue).to respond_to(:venue_wines)
      end

      it 'has many venue' do
        venue = create(:wine)

        expect(venue).to respond_to(:venues)
      end
    end

    context "Factory" do
      it "should be a wine" do
        expect(create(:wine)).to be_a(Wine)
      end

      it "should have attributes" do
        wine = create(:wine)
        expect(wine.name).to be_a(String)
        expect(wine.varietal).to be_a(String)
        expect(wine.vintage).to be_a(String)
        expect(wine.vineyard).to be_a(String)
        expect(wine.rating).to be_a(Integer)
        expect(wine.description).to be_a(String)
      end
    end
  end
end
