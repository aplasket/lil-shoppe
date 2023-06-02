require "rails_helper"

RSpec.describe "/admin, index page", type: :feature do
  describe "as an admin, when I visit index page:" do
    it "i see a header indicating it's the dashboard" do
      visit "/admin"

      expect(page).to have_content("Admin Dashboard")
    end

    it "I see a link to admin merchants index and admin invoices index" do
      visit "/admin"

      within ".header" do
        expect(page).to have_link("Admin Merchants Index")
        expect(page).to have_link("Admin Invoices Index")
      end
    end
  end

  describe "Admin Dashboard Stats - Top Customers" do
    let!(:customer1) { create(:customer) } # 5 successful transactions
    let!(:customer2) { create(:customer) } # 4 successful transactions
    let!(:customer3) { create(:customer) } # 3 successful transactions
    let!(:customer4) { create(:customer) } # 2 successful transactions
    let!(:customer5) { create(:customer) } # 1 successful transactions
    let!(:customer6) { create(:customer) } # 0 successful transactions

    before(:each) do
      5.times do
        invoice = create(:invoice, customer: customer1)
        create(:transaction, result: true, invoice: invoice)
      end

      4.times do
        invoice = create(:invoice, customer: customer2)
        create(:transaction, result: true, invoice: invoice)
      end

      3.times do
        invoice = create(:invoice, customer: customer3)
        create(:transaction, result: true, invoice: invoice)
      end

      2.times do
        invoice = create(:invoice, customer: customer4)
        create(:transaction, result: true, invoice: invoice)
      end

      invoice = create(:invoice, customer: customer5)
      create(:transaction, result: true, invoice: invoice)
      create(:transaction, result: false, invoice: invoice)

      2.times do
        invoice = create(:invoice, customer: customer6)
        create(:transaction, result: false, invoice: invoice)
      end
    end
  end
end
