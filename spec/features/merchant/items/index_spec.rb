require "rails_helper"

RSpec.describe "Merchant_items#index" do
  let!(:merchant_1) { Merchant.create!(name: "Steve's Soaps") }
  let!(:merchant_2) { Merchant.create!(name: "Charlie's Chia Pets") }
  let!(:item_1) { merchant_1.items.create!(name: "hand soap", description: "lavender", unit_price: 800) }
  let!(:item_2) { merchant_1.items.create!(name: "sugar scrub", description: "lemongrass", unit_price: 1000) }
  let!(:item_3) { merchant_2.items.create!(name: "Bob Ross Chia", description: "medium chia pet", unit_price: 1500) }

  it "shows all of the names of all of the merchants items" do
    visit merchant_items_path(merchant_1)

    expect(page).to have_content(item_1.name)
    expect(page).to have_content(item_2.name)
    expect(page).to have_no_content(item_3.name)
  end
end
