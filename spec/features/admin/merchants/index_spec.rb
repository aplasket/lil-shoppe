require "rails_helper"

RSpec.describe "/admin/merchants, admin::merchants index page" do
  let!(:merchant_1) { create(:merchant) }
  let!(:merchant_2) { create(:merchant) }

  describe "as an admin on the admin::merchants index page" do
    it "I see the name of each merchant" do
      visit "/admin/merchants"

      expect(page).to have_content(merchant_1.name)
      expect(page).to have_content(merchant_2.name)
    end
  end
end
