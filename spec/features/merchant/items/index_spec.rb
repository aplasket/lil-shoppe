require "rails_helper"

RSpec.describe "Merchant_items#index", type: :feature do
  let!(:merchant_1) { Merchant.create!(name: "Steve's Soaps") }
  let!(:merchant_2) { Merchant.create!(name: "Charlie's Chia Pets") }
  let!(:item_1) { merchant_1.items.create!(name: "hand soap", description: "lavender", unit_price: 800, status: 1) }
  let!(:item_2) { merchant_1.items.create!(name: "sugar scrub", description: "lemongrass", unit_price: 1000, status: :disabled) }
  let!(:item_3) { merchant_2.items.create!(name: "Bob Ross Chia", description: "medium chia pet", unit_price: 1500, status: :enabled) }

  it "shows all of the names of all of the merchant's items" do
    visit merchant_items_path(merchant_1)
require 'pry'; binding.pry
    expect(page).to have_content(item_1.name)
    expect(page).to have_content(item_2.name)
    expect(page).to have_no_content(item_3.name)
  end

  # 9. Merchant Item Disable/Enable

  # As a merchant
  # When I visit my items index page (/merchants/:merchant_id/items)
  # Next to each item name I see a button to disable or enable that item.
  # When I click this button
  # Then I am redirected back to the items index
  # And I see that the items status has changed

  it "displays a disable/enable button next to each item name" do
    visit "/merchants/#{merchant_1.id}/items"
    require 'pry'; binding.pry
    within "#merchants_items-#{item_1.id}" do
    expect(page).to have_content("#{item_1.name} Status: enabled")
      expect(page).to have_button("Disable Item")
      click_button "Disable Item"
    end

    within "#merchants_items-#{item1.id}" do
      expect(current_path).to eq("/merchants/#{merchant-1.id}/items")
      expect(page).to have_content("#{item_1.name} Status: disabled")
      expect(page).to have_button("Enable Item")
    end
  end
end
