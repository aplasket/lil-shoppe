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






    it "display names of top 5 customers with largest successful transactions " do
      visit "/merchants/#{merchant_1.id}/dashboard"


    end

    it "displays number of successful transactions for top 5 customers" do
      visit "/merchants/#{merchant_1.id}/dashboard"

      
    end




  end
end








