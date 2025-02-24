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
      visit merchant_dashboard_path(merchant_1)

      within("#top5") do
        expect(customer_1.first_name).to appear_before(customer_2.first_name)
        expect(customer_2.first_name).to appear_before(customer_3.first_name)
        expect(customer_3.first_name).to appear_before(customer_4.first_name)
        expect(customer_4.first_name).to appear_before(customer_5.first_name)
        expect(page).to_not have_content(customer_6.first_name)
      end
    end

    it "displays number of successful transactions for top 5 customers" do
      visit merchant_dashboard_path(merchant_1)

      within("#top5") do
        expect(
          "#{customer_1.successful_transactions_count} successful transactions"
        ).to appear_before(
          "#{customer_2.successful_transactions_count} successful transactions"
        )
        expect(
          "#{customer_2.successful_transactions_count} successful transactions"
        ).to appear_before(
          "#{customer_3.successful_transactions_count} successful transactions"
        )
        expect(
          "#{customer_3.successful_transactions_count} successful transactions"
        ).to appear_before(
          "#{customer_4.successful_transactions_count} successful transactions"
        )
        expect(
          "#{customer_4.successful_transactions_count} successful transactions"
        ).to appear_before(
          "#{customer_5.successful_transactions_count} successful transactions"
        )
        expect(page).to_not have_content(customer_6.successful_transactions_count.to_s)
      end
    end
  end
end
