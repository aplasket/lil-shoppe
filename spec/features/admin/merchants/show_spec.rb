require "rails_helper"

RSpec.describe "/admin/merchants/:id, admin::merchants show page" do
  let!(:merchant_1) { create(:merchant) }
  let!(:merchant_2) { create(:merchant) }

  describe "as an admin on admin::merchants index page" do
    it "each merchant link navigates to admin::merchants show page" do
      visit admin_merchants_path
      click_link("#{merchant_1.name}")

      expect(current_path).to eq(admin_merchant_path(merchant_1))
      expect(page).to have_content(merchant_1.name)
      expect(page).to_not have_content(merchant_2.name)

      visit admin_merchant_path(merchant_2)
      expect(page).to have_content(merchant_2.name)
      expect(page).to_not have_content(merchant_1.name)
    end
  end
end
