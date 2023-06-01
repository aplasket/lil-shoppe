require "rails_helper"

RSpec.describe Merchant, type: :feature do
    # 1. Merchant Dashboard

    # As a merchant,
    # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
    # Then I see the name of my merchant

  describe "as a merchant, I visit my dashboard" do
    let!(:merchant_1) { Merchant.create!(name: "Steve's Soaps") }
    let!(:merchant_2) { Merchant.create!(name: "Charlie's Chia Pets") }

    it "has the name of my merchant" do
      visit "/merchants/#{merchant_1.id}/dashboard"

      save_and_open_page

      within("#merchant-#{merchant_1.id}") do
        expect(page).to have_content(merchant_1.name)
      end
    end
  end
end