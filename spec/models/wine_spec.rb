require 'rails_helper'

RSpec.describe Wine, type: :model do
  describe "validations" do
    context "invalid attributes" do
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:code) }
    end

    context "valid attributes" do
      it "is valid with a name and code" do
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
        expect(wine.code).to be_a(String)
      end
    end
  end

  # describe "instance_methods" do
  #   it "#average_review_rating returns average rating of wine from reviews" do
  #     wine_1, wine_2 = create_list(:wine, 2)
  #     create(:review, reviewable_type: "Wine", reviewable_id: wine_1.id, rating: 5)
  #     create(:review, reviewable_type: "Wine", reviewable_id: wine_1.id, rating: 1)
  #     create(:review, reviewable_type: "Wine", reviewable_id: wine_1.id, rating: 3)
  #
  #     create(:review, reviewable_type: "Wine", reviewable_id: wine_2.id, rating: 3)
  #     create(:review, reviewable_type: "Wine", reviewable_id: wine_2.id, rating: 4)
  #     create(:review, reviewable_type: "Wine", reviewable_id: wine_2.id, rating: 4)
  #
  #     expect(wine_1.average_review_rating).to eq(3)
  #     expect(wine_2.average_review_rating).to eq(3.7)
  #   end
  #
  #   it "#half_rating_star? returns true if decimal place of wine rating is between .2 and .8" do
  #     wine_1, wine_2 = create_list(:wine, 2)
  #     create(:review, reviewable_type: "Wine", reviewable_id: wine_1.id, rating: 5)
  #     create(:review, reviewable_type: "Wine", reviewable_id: wine_1.id, rating: 1)
  #     create(:review, reviewable_type: "Wine", reviewable_id: wine_1.id, rating: 3)
  #
  #     create(:review, reviewable_type: "Wine", reviewable_id: wine_2.id, rating: 3)
  #     create(:review, reviewable_type: "Wine", reviewable_id: wine_2.id, rating: 4)
  #     create(:review, reviewable_type: "Wine", reviewable_id: wine_2.id, rating: 4)
  #
  #     expect(wine_1.half_star?).to eq(false)
  #     expect(wine_2.half_star?).to eq(true)
  #   end
  # end
end
