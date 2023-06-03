require "rails_helper"

RSpec.describe "/admin/merchants, admin::merchants index page" do
  let!(:merchant_1) { create(:merchant) }
  let!(:merchant_2) { create(:merchant) }

  describe "as an admin on the admin::merchants index page" do
    it "I see the name of each merchant and their links" do
      visit "/admin/merchants"
      save_and_open_page
      expect(page).to have_link(merchant_1.name)
      expect(page).to have_link(merchant_2.name)
    end

    it "each merchant link navigates to admin::merchants show page" do
      visit "/admin/merchants"
      click_link("#{merchant_1.name}")

      expect(current_path).to eq("admin/merchants/#{merchant_1.id}")
      expect(page).to have_content(merchant_1.name)
      expect(page).to_not have_content(merchant_2.name)

      visit "/admin/merchants/#{merchant_2.id}"
      expect(page).to have_content(merchant_2.name)
      expect(page).to_not have_content(merchant_1.name)
    end
  end
end
