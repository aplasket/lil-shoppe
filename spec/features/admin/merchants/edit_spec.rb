require "rails_helper"

RSpec.describe "/admin/merchants/:id/edit, admin::merchants edit page" do
  let!(:merchant_1) { create(:merchant) }
  let!(:merchant_2) { create(:merchant) }

  describe "as an admin on the admin::merchants edit page"
  it "can update the merchant's info and see a 'successful update' flash message" do
      merchant_3 = Merchant.create!(name: "Toasty Toads")

      visit "/admin/merchants/#{merchant_3.id}"

      expect(page).to have_content(merchant_3.name)
      expect(page).to have_link("Update #{merchant_3.name}")
      expect(page).to_not have_link("Update #{merchant_1.name}")
      expect(page).to_not have_link("Update #{merchant_2.name}")

      click_link "Update #{merchant_3.name}"

      fill_in "Name", with: "Cheesy Bread"
      click_button "Submit Updates"

      expect(current_path).to eq("/admin/merchants/#{merchant_3.id}")
      expect(page).to have_content("Merchant has been successfully updated")
      expect(page).to have_content("Cheesy Bread")
      expect(page).to_not have_content("Toasty Toads")
    end