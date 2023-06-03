require "rails_helper"

RSpec.describe "/admin/merchants/:id, admin::merchants show page" do
  let!(:merchant_1) { create(:merchant) }
  let!(:merchant_2) { create(:merchant) }

  describe "as an admin on admin::merchants show page" do
    it "each merchant link navigates to a show page" do
      visit "/admin/merchants"
      click_link("#{merchant_1.name}")

      expect(current_path).to eq("/admin/merchants/#{merchant_1.id}")
      expect(page).to have_content(merchant_1.name)
      expect(page).to_not have_content(merchant_2.name)

      visit "/admin/merchants/#{merchant_2.id}"
      expect(page).to have_content(merchant_2.name)
      expect(page).to_not have_content(merchant_1.name)
    end

    it "has a button to update a merchant's info" do
      merchant_3 = Merchant.create!(name: "Toasty Toads")

      visit "/admin/merchants/#{merchant_3.id}"
      save_and_open_page
      expect(page).to have_content(merchant_3.name)
      expect(page).to have_link("Update #{merchant_3.name}")
      expect(page).to_not have_link("Update #{merchant_1.name}")
      expect(page).to_not have_link("Update #{merchant_2.name}")
    end
  end
end
