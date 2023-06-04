require "rails_helper"

RSpec.describe "Merchant_items#index", type: :feature do
  let!(:merchant_1) { Merchant.create!(name: "Steve's Soaps") }
  let!(:merchant_2) { Merchant.create!(name: "Charlie's Chia Pets") }
  let!(:item_1) { merchant_1.items.create!(name: "hand soap", description: "lavender", unit_price: 800) }
  let!(:item_2) { merchant_1.items.create!(name: "sugar scrub", description: "lemongrass", unit_price: 1000) }
  let!(:item_3) { merchant_2.items.create!(name: "Bob Ross Chia", description: "medium chia pet", unit_price: 1500) }

  it "shows all of the names of all of the merchant's items" do
    visit merchant_items_path(merchant_1)

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

  it "displays a disable button next to each item name" do
    visit merchant_items_path(merchant_1)

    expect(page).to have_content(item_1.name)
    expect(page).to have_button("Disable")
  end

  it "displays an enable button when an item is disabled" do
    item_1.update(status: :disabled)

    visit merchant_items_path(merchant_1)

    expect(page).to have_content(item_1.name)
    expect(page).to have_button("Enable")
  end

  it "changes the item status when the disable button is clicked" do
    visit merchant_items_path(merchant_1)

    within("#item-#{item_1.id}") do
      click_button "Disable"
    end

    expect(item_1.reload.status).to eq("disabled")
  end

  it "changes the item status when the enable button is clicked" do
    item_1.update(status: :disabled)

    visit merchant_items_path(merchant_1)

    within("#item-#{item_1.id}") do
      click_button "Enable"
    end

    expect(item_1.reload.status).to eq("enabled")
  end

  it "redirects back to the items index page after disabling or enabling an item" do
    visit merchant_items_path(merchant_1)

    within("#item-#{item_1.id}") do
      click_button "Disable"
    end

    expect(page).to have_current_path(merchant_items_path(merchant_1))

    within("#item-#{item_1.id}") do
      click_button "Enable"
    end

    expect(page).to have_current_path(merchant_items_path(merchant_1))
  end
end