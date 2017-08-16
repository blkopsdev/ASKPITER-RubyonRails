require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

# Feature: Reviews
#   As a user
#   I want to add review
feature 'Reviews', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User adds review
  #   Given I am signed in
  #   When I click "Add review" and fill all fields, set rating and press upload
  #   Then I I see my review added on Product page
  scenario 'user adds review' do
    user = FactoryGirl.create(:user)
    product = FactoryGirl.create(:product)
    login_as(user, :scope => :user)
    visit product_path(product)
    expect(page).to have_content(/.*#{product.name}.*/)
  end

end
