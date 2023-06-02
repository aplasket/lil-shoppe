require "rails_helper"

RSpec.describe "/admin, index page", type: :feature do
  describe "as an admin, when I visit index page:" do
    it "i see a header indicating it's the dashboard" do
      visit "/admin"

      expect(page).to have_content("Admin Dashboard")
    end

    it "I see a link to admin merchants index and admin invoices index" do
      visit "/admin"

      within ".header" do
        expect(page).to have_link("Admin Merchants Index")
        expect(page).to have_link("Admin Invoices Index")
      end
    end
  end
end
