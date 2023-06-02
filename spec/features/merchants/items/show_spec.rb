require "rails_helper"

RSpec.describe "Merchant_items#show" do
# 7. Merchant Items Show Page

# As a merchant,
# When I click on the name of an item from the merchant items index page, (merchants/:merchant_id/items)
# Then I am taken to that merchant's item's show page (/merchants/:merchant_id/items/:item_id)
# And I see all of the item's attributes including:

# - Name
# - Description
# - Current Selling Price
let!(:merchant_1) { Merchant.create!(name: "Steve's Soaps") }
let!(:merchant_2) { Merchant.create!(name: "Charlie's Chia Pets") }
let!(:item_1) { merchant_1.items.create!(name: "hand soap", description: "lavender", unit_price: 800) }
let!(:item_2) { merchant_1.items.create!(name: "sugar scrub", description: "lemongrass", unit_price: 1000) }
let!(:item_3) { merchant_2.items.create!(name: "Bob Ross Chia", description: "medium chia pet", unit_price: 1500) }

it "links to the merchant's item's show page"
  visit "/merchants/#{merchant_1.id}/items"

  click_link "item_1.name"

  expect(current_path).to eq "/merchants/#{merchant_1.id}/items/#{item_1.id}"
  expect(page).to have_content(item_1.name)
  expect(page).to have_content(item_1.description)
  expect(page).to have_content(item_1.unit_price)
end

