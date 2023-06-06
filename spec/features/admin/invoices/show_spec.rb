require "rails_helper"

RSpec.describe "Admin Invoices Show Page", type: :feature do
  before (:each) do
    @merchant_1 = create(:merchant)
    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @invoice_1 = create(:invoice, customer: @customer_1)
    @invoice_2 = create(:invoice, customer: @customer_2)
    @item_1 = create(:item, merchant: @merchant_1)
    @item_2 = create(:item, merchant: @merchant_1)
    @item_3 = create(:item, merchant: @merchant_1)
    @invoice_item_1 = create(:invoice_item, invoice: @invoice_1, item: @item_1, quantity: 50, unit_price: 50)
    @invoice_item_2 = create(:invoice_item, invoice: @invoice_1, item: @item_2, quantity: 100, unit_price: 100)
    @invoice_item_3 = create(:invoice_item, invoice: @invoice_2, item: @item_1, quantity: 150, unit_price: 150)
    @invoice_item_4 = create(:invoice_item, invoice: @invoice_2, item: @item_3, quantity: 200, unit_price: 200)
  end

  describe "As an Admin, when I visit an admin invoice show page" do
    it "displays all the information related to that invoice" do
      visit admin_invoice_path(@invoice_1)

      expect(page).to have_content("Invoice ID: #{@invoice_1.id}")
      expect(page).to have_content("Invoice Status: #{@invoice_1.status}")
      expect(page).to have_content("Invoice Created On: #{@invoice_1.created_at.strftime('%A, %B %d, %Y')}")
      expect(page).to have_content("Customer Name: #{@customer_1.first_name} #{@customer_1.last_name}")

      expect(page).to_not have_content("Invoice ID: #{@invoice_2.id}")
      expect(page).to_not have_content(
        "Customer Name: #{@invoice_2.customer.first_name} #{@invoice_2.customer.last_name}"
      )

      visit admin_invoice_path(@invoice_2)

      expect(page).to have_content("Invoice ID: #{@invoice_2.id}")
      expect(page).to have_content("Invoice Status: #{@invoice_2.status}")
      expect(page).to have_content("Invoice Created On: #{@invoice_2.created_at.strftime('%A, %B %d, %Y')}")
      expect(page).to have_content("Customer Name: #{@customer_2.first_name} #{@customer_2.last_name}")

      expect(page).to_not have_content("Invoice ID: #{@invoice_1.id}")
      expect(page).to_not have_content(
        "Customer Name: #{@invoice_1.customer.first_name} #{@invoice_1.customer.last_name}"
)
    end

    it "displays all the Items on that invoice and all the items information" do
      visit admin_invoice_path(@invoice_1)

      within("#item_#{@item_1.id}") do
        expect(page).to have_content("Item name: #{@item_1.name}")
        expect(page).to have_content("Quantity Ordered: #{@invoice_item_1.quantity}")
        expect(page).to have_content("Item Sold Price: $#{@invoice_item_1.unit_price/ 100.to_f}")
        expect(page).to have_content("Invoice Item Status: #{@invoice_item_1.status}")
      end

      within("#item_#{@item_2.id}") do
        expect(page).to have_content("Item name: #{@item_2.name}")
        expect(page).to have_content("Quantity Ordered: #{@invoice_item_2.quantity}")
        expect(page).to have_content("Item Sold Price: $#{@invoice_item_2.unit_price/ 100.to_f}")
        expect(page).to have_content("Invoice Item Status: #{@invoice_item_2.status}")
      end
    end

    it "displays the total revenue that will be generated from this invoice" do
      visit admin_invoice_path(@invoice_1)
      
      expect(page).to have_content("Total Revenue: $125.00")
      expect(page).to_not have_content("Total Revenue: $625.00")

      visit admin_invoice_path(@invoice_2)

      expect(page).to have_content("Total Revenue: $625.00")
      expect(page).to_not have_content("Total Revenue: $125.00")
    end
  end
end
