require "rails_helper"

RSpec.describe "Merchant_items#show" do
  let!(:merchant_1) { Merchant.create!(name: "Steve's Soaps") }
  let!(:merchant_2) { Merchant.create!(name: "Charlie's Chia Pets") }
  let!(:item_1) { merchant_1.items.create!(name: "hand soap", description: "lavender", unit_price: 800) }
  let!(:item_2) { merchant_1.items.create!(name: "sugar scrub", description: "lemongrass", unit_price: 1000) }
  let!(:item_3) { merchant_2.items.create!(name: "Bob Ross Chia", description: "medium chia pet", unit_price: 1500) }

  it "links to the merchant's item's show page" do
    visit "/merchants/#{merchant_1.id}/items"

    click_link "hand soap"

    expect(current_path).to eq "/merchants/#{merchant_1.id}/items/#{item_1.id}"
    expect(page).to have_content("Name")
    expect(page).to have_content(item_1.name)
    expect(page).to have_content("Description")
    expect(page).to have_content(item_1.description)
    expect(page).to have_content("Current Selling Price")
    expect(page).to have_content("$8.00")
  end

  # As a merchant,
  # When I visit the merchant show page of an item (/merchants/:merchant_id/items/:item_id)
  # I see a link to update the item information.
  # When I click the link
  # Then I am taken to a page to edit this item
  # And I see a form filled in with the existing item attribute information
  # When I update the information in the form and I click ‘submit’
  # Then I am redirected back to the item show page where I see the updated information
  # And I see a flash message stating that the information has been successfully updated.
  it "can update item information" do
    visit "/merchants/#{merchant_1.id}/items/#{item_1.id}"

    click_link "Update Item"

    expect(current_path).to eq "/merchants/#{merchant_1.id}/items/#{item_1.id}/edit"
    expect(page).to have_content(item_1.name)
    expect(page).to have_content(item_1.description)
    expect(page).to have_content("$8.00")

    fill_in "Description", with: "aloe"

    click_button "Submit"

    expect(current_path).to eq "/merchants/#{merchant_1.id}/items/#{item_1.id}"
    expect(page).to have_content("aloe")
    expect(page).to have_content("Information has been successfully updated")
  end

end