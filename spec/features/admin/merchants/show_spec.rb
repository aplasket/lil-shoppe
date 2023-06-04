require "rails_helper"

RSpec.describe "/admin/merchants/:id, admin::merchants show page" do
  describe "as an admin on admin::merchants show page" do
    it "each merchant link navigates to a show page" do
      merchant_1 = Merchant.create!(name: "GingerBread Maker")
      merchant_2 = Merchant.create!(name: "CandyMan")

      visit "/admin/merchants"

      expect(page).to have_link("#{merchant_1.name}")

      click_link("#{merchant_1.name}")

      expect(current_path).to eq(admin_merchant_path(merchant_1))
      expect(page).to have_content(merchant_1.name)
      expect(page).to_not have_content(merchant_2.name)

      visit "/admin/merchants/#{merchant_2.id}"
      expect(page).to have_content(merchant_2.name)
      expect(page).to_not have_content(merchant_1.name)
    end

    it "has a button to update a merchant's info" do
      merchant_1 = Merchant.create!(name: "GingerBread Maker")
      merchant_2 = Merchant.create!(name: "CandyMan")
      merchant_3 = Merchant.create!(name: "Toasty Toads")

      visit "/admin/merchants/#{merchant_3.id}"

      expect(page).to have_content(merchant_3.name)
      expect(page).to have_link("Update #{merchant_3.name}")
      expect(page).to_not have_link("Update #{merchant_1.name}")
      expect(page).to_not have_link("Update #{merchant_2.name}")
    end
  end
end
