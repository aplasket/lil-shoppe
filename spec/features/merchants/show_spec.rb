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
    before(:each) do
    @merchant_1 = Merchant.create!(name: "Steve's Soaps")
    @merchant_2 = Merchant.create!(name: "Charlie's Chia Pets")
    @customer_1 = Customer.create!(first_name: "John", last_name: "Smith")
    @customer_2 = Customer.create!(first_name: "Jane", last_name: "Doe")
    @item_1 = Item.create!(name: "Soap", description: "Clean", unit_price: 100, merchant_id: merchant_1.id)
    @item_2 = Item.create!(name: "Shampoo", description: "Clean", unit_price: 600, merchant_id: merchant_1.id)
    @item_3 = Item.create!(name: "Conditioner", description: "Clean", unit_price: 500, merchant_id: merchant_1.id)
    @invoice_items_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: 100)
    @invoice_items_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, quantity: 1, unit_price: 600)
    @invoice_items_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, quantity: 1, unit_price: 500)
    @invoice_1 = Invoice.create!(customer_id: customer_1.id, status: "packaged")
    @invoice_2 = Invoice.create!(customer_id: customer_2.id, status: "pending")
    @invoice_3 = Invoice.create!(customer_id: customer_2.id, status: "shipped")
    @transaction_1 = Transaction.create!(invoice_id: invoice_1.id, result: "success")
    @transaction_2 = Transaction.create!(invoice_id: invoice_2.id, result: "success")
    @transaction_3 = Transaction.create!(invoice_id: invoice_3.id, result: "success")
    end
    # As a merchant
    # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
    # Then I see a section for "Items Ready to Ship"
    # In that section I see a list of the names of all of my items that
    # have been ordered and have not yet been shipped,
    # And next to each Item I see the id of the invoice that ordered my item
    # And each invoice id is a link to my merchant's invoice show page

    it 'display a section with "Items Ready to Ship" with a list of all those items' do
      visit "/merchants/#{merchant_1.id}/dashboard"

      within("#ItemsReadyShip") do
        expect(page).to have_content("Items Ready to Ship")
        expect(page).to have_content(item_1.name)
        expect(page).to have_content(item_2.name)
        expect(page).to have_content(item_3.name)
      end
    end

    it 'display id of the invoice that ordered the item as a link to that merchant show page' do
      visit "/merchants/#{merchant_1.id}/dashboard"

      within("#ItemsReadyShip") do
      end

    end
  end
end
