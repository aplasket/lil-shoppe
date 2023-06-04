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
    let!(:merchant_1) { Merchant.create!(name: "Steve's Soaps") }
    let!(:merchant_2) { Merchant.create!(name: "Charlie's Chia Pets") }
    let!(:customer_1) { create(:customer) } # 5 successful transactions
    let!(:customer_2) { create(:customer) } # 4 successful transactions
    let!(:customer_3) { create(:customer) } # 3 successful transactions
    let!(:customer_4) { create(:customer) } # 2 successful transactions
    let!(:customer_5) { create(:customer) } # 1 successful transactions
    let!(:customer_6) { create(:customer) } # 0 successful transactions
    
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

      within("#top5") do
        expect(customer_1.first_name).to appear_before(customer_2.first_name)
        expect(customer_2.first_name).to appear_before(customer_3.first_name)
        expect(customer_3.first_name).to appear_before(customer_4.first_name)
        expect(customer_4.first_name).to appear_before(customer_5.first_name)
        expect(page).to_not have_content(customer_6.first_name)
      end
    end

    it "displays number of successful transactions for top 5 customers" do
      visit "/merchants/#{merchant_1.id}/dashboard"

      within("#top5") do
        expect("#{customer_1.successful_transactions_count} successful transactions").to appear_before("#{customer_2.successful_transactions_count} successful transactions")
        expect("#{customer_2.successful_transactions_count} successful transactions").to appear_before("#{customer_3.successful_transactions_count} successful transactions")
        expect("#{customer_3.successful_transactions_count} successful transactions").to appear_before("#{customer_4.successful_transactions_count} successful transactions")
        expect("#{customer_4.successful_transactions_count} successful transactions").to appear_before("#{customer_5.successful_transactions_count} successful transactions")
        expect(page).to_not have_content("#{customer_6.successful_transactions_count}")
      end
    end
  end

  describe "Merchant Dashboard Stats - Merchant Dashboard Items Ready to Ship" do
    let!(:merchant_1) { create(:merchant) }
    let!(:merchant_2) { create(:merchant) }
    let!(:customer_1) { create(:customer) } 
    let!(:customer_2) { create(:customer) } 
    let!(:customer_3) { create(:customer) }
    let!(:item_1) { create(:item, merchant: merchant_1) }
    let!(:item_2) { create(:item, merchant: merchant_1) }
    let!(:item_3) { create(:item, merchant: merchant_1) }
    let!(:item_4) { create(:item, merchant: merchant_2) }
    let!(:invoice_items_1) { create(:invoice_item, item: item_1) }
    let!(:invoice_items_1) { create(:invoice_item, item: item_2) }
    let!(:invoice_items_2) { create(:invoice_item, item: item_3) }
    let!(:invoice_items_3) { create(:invoice_item, item: item_4) }
    let!(:invoice_1) { create(:invoice, customer: customer_1) }
    let!(:invoice_2) { create(:invoice, customer: customer_2) }
    let!(:invoice_3) { create(:invoice, customer: customer_3) }
    
    before(:each) do
      5.times do
        invoice_items = create(:invoice_item, item: item_1)
        invoice = create(:invoice, customer: customer_1)
        create(:transaction, result: true, invoice: invoice)
      end

      4.times do
        invoice = create(:invoice, customer: customer_2)
        create(:transaction, result: false, invoice: invoice)
      end

      3.times do
        invoice = create(:invoice, customer: customer_3)
        create(:transaction, result: false, invoice: invoice)
      end

    end
    it 'display a section with "Items Ready to Ship" with a list of all those items' do
      visit "/merchants/#{merchant_1.id}/dashboard"

      within("#ItemsReadyShip") do
        expect(page).to have_content("Items Ready to Ship")


      end
    end

    it 'display id of the invoice that ordered the item as a link to that merchant show page' do
      visit "/merchants/#{merchant_1.id}/dashboard"

      within("#ItemsReadyShip") do

    end
  end
end
