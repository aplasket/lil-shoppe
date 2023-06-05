require "rails_helper"

RSpec.describe "Merchant_items#index", type: :feature do
  let!(:merchant_1) { Merchant.create!(name: "Steve's Soaps") }
  let!(:merchant_2) { Merchant.create!(name: "Charlie's Chia Pets") }
  let!(:item_1) { merchant_1.items.create!(name: "hand soap", description: "lavender", unit_price: 800, status: "enabled") }
  let!(:item_2) { merchant_1.items.create!(name: "sugar scrub", description: "lemongrass", unit_price: 1000, status: "enabled") }
  let!(:item_3) { merchant_2.items.create!(name: "Bob Ross Chia", description: "medium chia pet", unit_price: 1500, status: "enabled") }

  it "shows all of the names of all of the merchant's items" do
    visit merchant_items_path(merchant_id: merchant_1.id)

    expect(page).to have_content(item_1.name)
    expect(page).to have_content(item_2.name)
    expect(page).to have_no_content(item_3.name)
  end

  it "displays a button that will enable or disable each item" do
    visit merchant_items_path(merchant_id: merchant_1.id)
    save_and_open_page
    within ".enabled-items" do
      expect(page).to have_content("Enabled Items")
      expect(page).to have_link(item_1.name)
      expect(page).to have_link(item_2.name)

      expect(page).to have_button("Disable #{item_1.name}")
      expect(page).to have_button("Disable #{item_2.name}")

      click_button "Disable #{item_1.name}"
    end

    expect(current_path).to eq(merchant_items_path(merchant_id: merchant_1.id))

    within ".disabled-items" do
      expect(page).to have_content("Disabled Items")
      expect(page).to have_link(item_1.name)
      expect(page).to_not have_content(item_2.name)

      expect(page).to have_button("Enable #{item_1.name}")
    end

    within ".enabled-items" do
      save_and_open_page
      expect(page).to_not have_link(item_1.name)
      expect(page).to_not have_button("Enable #{item_2.name}")
    end
  end
end


