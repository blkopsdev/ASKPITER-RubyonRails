require 'rails_helper'

RSpec.feature "Searches", type: :feature do

  scenario 'searching for a product by name returns that product' do
    prod = FactoryGirl.create(:product, name: 'blue widget')
    visit root_path
    fill_in :search, with: 'widget'
    find('.submit-icon').click
    expect(page).to have_content 'blue widget'
  end

  scenario 'searching for a product by description returns that product' do
    prod = FactoryGirl.create(:product, name: 'blue widget', description: 'a splendid piece of kit')
    visit root_path
    fill_in :search, with: 'splendid'
    find('.submit-icon').click
    expect(page).to have_content 'blue widget'
  end

  scenario "displays a message if no products are returned" do
    visit root_path
    fill_in :search, with: 'splendid'
    find('.submit-icon').click
    expect(page).to have_content 'returned no products'
  end

end
