require "rails_helper"

RSpec.describe Merchant, type: :feature do
  describe "as a merchant, I visit my dashboard" do
    let!(:merchant_1) { Merchant.create!(name: "Steve's Soaps") }
    let!(:merchant_2) { Merchant.create!(name: "Charlie's Chia Pets") }

    it "has the name of my merchant" do
      visit merchant_dashboard_path(merchant_1)

      expect(page).to have_content(merchant_1.name)
      expect(page).to_not have_content(merchant_2.name)
    end

    it "displays link to merchant items index" do
      visit merchant_dashboard_path(merchant_1)

      click_link "Items"

      expect(current_path).to eq(merchant_items_path(merchant_1))
      expect(current_path).to_not eq(merchant_items_path(merchant_2))
    end

    it "displays link to merchant invoices index" do
      visit merchant_dashboard_path(merchant_1)

      click_link "Invoices"

      expect(current_path).to eq(merchant_invoices_path(merchant_1))
      expect(current_path).to_not eq(merchant_invoices_path(merchant_2))
    end
  end
end
