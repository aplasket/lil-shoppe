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

    it "displays link to merchant items index" do
      visit "/merchants/#{merchant_1.id}/dashboard"

      click_link "Items"

      expect(current_path).to eq("/merchants/#{merchant_1.id}/items")
      expect(current_path).to_not eq("/merchants/#{merchant_2.id}/items")
    end

    it "displays link to merchant invoices index" do
      visit "/merchants/#{merchant_1.id}/dashboard"

      click_link "Invoices"

      expect(current_path).to eq("/merchants/#{merchant_1.id}/invoices")
      expect(current_path).to_not eq("/merchants/#{merchant_2.id}/invoices")
    end
  end

  describe "Merchant Dashboard Stats - Top 5 Customers" do
    let!(:customer_1) { create(:customer) } # 5 successful transactions
    let!(:customer_2) { create(:customer) } # 4 successful transactions
    let!(:customer_3) { create(:customer) } # 3 successful transactions
    let!(:customer_4) { create(:customer) } # 2 successful transactions
    let!(:customer_5) { create(:customer) } # _1 successful transactions
    let!(:customer_6) { create(:customer) } # _0 successful transactions
    
    before(:each) do
      5.times do
        invoice = create(:invoice, customer: customer_1)
        create(:transaction, result: true, invoice: invoice)
      end

      4.times do
        invoice = create(:invoice, customer: customer_2)
        create(:transaction, result: true, invoice: invoice)
      end

      3.times do
        invoice = create(:invoice, customer: customer_3)
        create(:transaction, result: true, invoice: invoice)
      end

      2.times do
        invoice = create(:invoice, customer: customer_4)
        create(:transaction, result: true, invoice: invoice)
      end

      invoice = create(:invoice, customer: customer_5)
      create(:transaction, result: true, invoice: invoice)
      create(:transaction, result: false, invoice: invoice)

      2.times do
        invoice = create(:invoice, customer: customer_6)
        create(:transaction, result: false, invoice: invoice)
      end
    end
    it "display names of top 5 customers with largest successful transactions " do
      
      
      visit "/merchants/#{merchant_1.id}/dashboard"


    end

    it "displays number of successful transactions for top 5 customers" do
      visit "/merchants/#{merchant_1.id}/dashboard"

      
    end
