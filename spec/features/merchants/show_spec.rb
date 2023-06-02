require "rails_helper"

RSpec.describe Merchant, type: :feature do
  describe "as a merchant, I visit my dashboard" do
    let!(:merchant_1) { Merchant.create!(name: "Steve's Soaps") }
    let!(:merchant_2) { Merchant.create!(name: "Charlie's Chia Pets") }

    it "has the name of my merchant" do
      visit "/merchants/#{merchant_1.id}/dashboard"

      expect(page).to have_content(merchant_1.name)
      expect(page).to_not have_content(merchant_2.name)
    end

    xit "display link to merchant items index" do
      visit "/merchants/#{merchant_1.id}/dashboard"

      click_link "Items"

      expect(current_path).to eq("/merchants/#{merchant_1.id}/items")
      expect(current_path).to_not eq("/merchants/#{merchant_2.id}/items")
    end

    xit "display link to merchant invoices index" do
      visit "/merchants/#{merchant_1.id}/dashboard"

      click_link "Invoices"

      expect(current_path).to eq("/merchants/#{merchant_1.id}/invoices")
      expect(current_path).to_not eq("/merchants/#{merchant_2.id}/invoices")
    end
  end
end