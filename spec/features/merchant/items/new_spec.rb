require "rails_helper"

RSpec.describe "Merchant_items#new", type: :feature do
  # US 11
  # As a merchant
  # When I visit my items index page
  # I see a link to create a new item.
  # When I click on the link,
  # I am taken to a form that allows me to add item information.
  # When I fill out the form I click ‘Submit’
  # Then I am taken back to the items index page
  # And I see the item I just created displayed in the list of items.
  # And I see my item was created with a default status of disabled.
  describe "as a visitor" do
    describe "when I am taken to a new item form" do
      let!(:merchant_1) { create(:merchant) }

      it "renders a form to create a new item" do
        visit merchant_items_path(merchant_id: merchant_1.id)
        expect(page).to have_content("Create New Item")
        fill_in "Name:", with: "coffee mug"
        fill_in "Description:", with: "stainless travel 16oz"
        fill_in "Unit Price:", with: "999"
        fill_in "status:", with: "disabled"

        click_button "Submit"

        expect(current_path).to eq("/merchants/#{merchant_1.id}/items")
        within ".disabled-items" do
          expect(page).to have_content("coffee mug")
        end
        click_link "coffee mug"
        expect(page).to have_content("Item Name: coffee mug")
        expect(page).to have_content("Description: stainless travle 16oz")
        expect(page).to have_content("Current Selling Price: $9.99")
      end
    end
  end
end