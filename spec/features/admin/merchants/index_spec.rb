require "rails_helper"

RSpec.describe "/admin/merchants, admin::merchants index page" do
  let!(:merchant_1) { create(:merchant) }
  let!(:merchant_2) { create(:merchant) }

  describe "as an admin on the admin::merchants index page" do
    it "I see the name of each merchant and their links" do
      visit admin_merchants_path

      expect(page).to have_link(merchant_1.name)
      expect(page).to have_link(merchant_2.name)
    end
  end
end
