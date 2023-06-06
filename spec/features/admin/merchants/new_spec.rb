require "rails_helper"

RSpec.describe "/admin/merchants/new, admin::merchants new page" do
  describe "as an admin, I can create a new merchant" do
    it "I see a form to create a new merchant - US29" do
      visit new_admin_merchant_path

      fill_in "Name", with: "Bob's Burgers"
      click_button "Submit"

      expect(current_path).to eq(admin_merchants_path)
      expect(page).to have_content("Merchant has been successfully created")

      within "#disabled-merchants" do
        expect(page).to have_content("Bob's Burgers")
      end
    end

    it "displays a flash message if name is not inputted" do
      visit new_admin_merchant_path
      expect(page).to have_content("New Merchant")

      fill_in "Name", with: ""

      click_button "Submit"

      expect(current_path).to eq(new_admin_merchant_path)
      expect(page).to have_content("Error: Name can't be blank")
    end
  end
end