require "rails_helper"

RSpec.describe "/admin, index page", type: :feature do
  describe "as an admin, when I visit index page:" do
    it "i see a header indicating it's the dashboard" do
      visit "/admin"

      expect(page).to have_content("Admin Dashboard")
    end
  end
end