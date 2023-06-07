require "rails_helper"

RSpec.describe "/admin, index page", type: :feature do
  describe "as an admin, when I visit index page:" do
    it "i see a header indicating it's the dashboard" do
      visit admin_index_path

      expect(page).to have_content("Admin Dashboard")
    end

    it "I see a link to admin merchants index and admin invoices index" do
      visit admin_index_path

      within ".header" do
        expect(page).to have_link("Admin Merchants Index")
        expect(page).to have_link("Admin Invoices Index")
      end
    end
  end

  describe "Admin Dashboard Stats - Top Customers" do
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

    it "displays the top 5 customers with their names and number of successful transactions" do
      visit admin_index_path

      expect(page).to have_content("Top Customers")

      within "#top-five-customers" do
        expect(customer_1.first_name).to appear_before(customer_2.first_name)
        expect(customer_2.first_name).to appear_before(customer_3.first_name)
        expect(customer_3.first_name).to appear_before(customer_4.first_name)
        expect(customer_4.first_name).to appear_before(customer_5.first_name)

        expect(page).to_not have_content(customer_6.first_name)
        expect(page).to_not have_content(customer_6.last_name)
      end
    end
  end

  describe "Admin Dashboard Incomplete Invoices" do
    before(:each) do
      merchant = create(:merchant)
      customer = create(:customer)

      item_1 = create(:item, merchant: merchant)
      item_2 = create(:item, merchant: merchant)
      item_3 = create(:item, merchant: merchant)
      item_4 = create(:item, merchant: merchant)
      item_5 = create(:item, merchant: merchant)
      item_6 = create(:item, merchant: merchant)

      @invoice_1 = create(:invoice, created_at: 3.day.ago, customer: customer) # 2 items that have not shipped
      @invoice_2 = create(:invoice, created_at: 2.day.ago, customer: customer) # 1 item shipped, 1 not shipped
      @invoice_3 = create(:invoice, created_at: 2.day.ago, customer: customer) # 2 items that have shipped

      @invoice_item_1 = create(:invoice_item, status: "pending", item: item_1, invoice: @invoice_1)
      @invoice_item_2 = create(:invoice_item, status: "packaged", item: item_2, invoice: @invoice_1)
      @invoice_item_3 = create(:invoice_item, status: "pending", item: item_3, invoice: @invoice_2)
      @invoice_item_4 = create(:invoice_item, status: "shipped", item: item_4, invoice: @invoice_2)
      @invoice_item_5 = create(:invoice_item, status: "shipped", item: item_5, invoice: @invoice_3)
      @invoice_item_6 = create(:invoice_item, status: "shipped", item: item_6, invoice: @invoice_3)
    end

    it "has a section for unshipped Incomplete Invoices with ids as links, ordered by creation, oldest to newest" do
      visit admin_index_path
      expect(page).to have_content("Incomplete Invoices")
      expect(page).to_not have_content("Invoice ##{@invoice_3.id}")

      within("#incomplete-invoices") do
        expect("Invoice ##{@invoice_1.id}").to appear_before("Invoice ##{@invoice_2.id}")
        expect(page).to have_content(@invoice_1.created_at.strftime("%A, %B %d, %Y"))
        expect(page).to have_link("Invoice ##{@invoice_1.id}")
        expect(page).to have_link("Invoice ##{@invoice_2.id}")
      end
    end
  end
end
