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

        expect(page).to have_content("Merchant Item Details")
        expect(page).to have_content("Merchant: #{merchant_1.name}")
        expect(page).to have_content("Item Name: #{item_1.name}")
        expect(page).to have_content("Item Description: #{item_1.description}")
        expect(page).to have_content("Current Selling Price: $#{item_1.unit_price / 100.to_f}")
      end


      # 8. Merchant Item Update

      # When I update the information in the form and I click ‘submit’
      # Then I am redirected back to the item show page where I see the updated information
      # And I see a flash message stating that the information has been successfully updated.

      it "updates merchant_items" do
        visit "/merchants/#{merchant_1.id}/items/#{item_1.id}"

        expect(page).to have_link "Update Item"

        click_link "Update Item"
        save_and_open_page

        expect(current_path).to eq "/merchants/#{merchant_1.id}/items/#{item_1.id}/edit"
        expect(find_field("item_name").value).to eq item_1.name
        expect(find_field("item_description").value).to eq item_1.description
        expect(find_field("item_unit_price").value.to_i).to eq 800





      end

    end