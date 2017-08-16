require "rails_helper"

describe Review, :type => :model do

  it "shouldn't creates without rating" do
    review = FactoryGirl.build(:review)
    expect(review).not_to be_valid
  end

  it "should creates with rating" do
    review_attributes = FactoryGirl.build(:review).attributes.except('created_at', 'updated_at').dup
    review_attributes[:rating_attributes] = FactoryGirl.attributes_for(:rating, :with_value)
    review = Review.new(review_attributes)
    expect(review).to be_valid
  end
  
end
