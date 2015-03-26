require 'rails_helper'

RSpec.describe "index page", type: :feature do
  before :each do
    Product.create!(:name => "apple corer", :description => "apple description", :price => 1.99, :minimum_age_appropriate => 3)
    Product.create!(:name => "banana peeler", :description => "banana description", :price => 2.99, :minimum_age_appropriate => 2, :maximum_age_appropriate => 2)

    visit "/products"
  end

  it "should have links from each product name to 'show' pages" do
    expect(page).to have_link("apple corer")
    expect(page).to have_link("banana peeler")
  end

  it "show link for product should show details for the product" do
    click_link("apple corer")
    expect(page).to have_link("Back to product list")
    expect(page).to have_content("apple corer")
    expect(page).to have_content("apple description")
    expect(page).to have_content("1.99")
    expect(page).to have_content("3 and above")
  end

  it "show link for product should show details for the product" do
    click_link("banana peeler")
    expect(page).to have_link("Back to product list")
    expect(page).to have_content("banana peeler")
    expect(page).to have_content("banana description")
    expect(page).to have_content("2.99")
    expect(page).to have_content("Age 2")
  end

end
