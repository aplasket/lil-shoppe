require 'rails_helper'

RSpec.describe 'Merchant Invoice Show Page', type: :feature do
  before (:each) do
    @merchant_1 = create(:merchant)

    @item_1 = create(:item, merchant: @merchant_1)
    @item_2 = create(:item, merchant: @merchant_1)

    @customer_1 = create(:customer)
    @customer_2 = create(:customer)

    @invoice_1 = create(:invoice, customer: @customer_1)
    @invoice_2 = create(:invoice, customer: @customer_1)

    @invoice_item_1 = create(:invoice_item, item: @item_1, invoice: @invoice_1)
    @invoice_item_2 = create(:invoice_item, item: @item_2, invoice: @invoice_1)
  end

  describe "When I visit a merchant's invoice show page" do
    it "displays the information related to that invoice" do
      visit merchant_invoice_path(@merchant_1, @invoice_1)

      expect(page).to have_content(@invoice_1.id)
      expect(page).to have_content(@invoice_1.status)
      expect(page).to have_content(@invoice_1.created_at.strftime("%A, %B %d, %Y"))
    end

    it "will display the item names, quantity ordered, price sold for, and invoice item status" do
      visit merchant_invoice_path(@merchant_1, @invoice_1)

      within("#item_#{@item_1.id}") do
        expect(page).to have_content("Item Name: #{@item_1.name}")
        expect(page).to have_content("Quantity: #{@invoice_item_1.quantity}")
        expect(page).to have_content("Unit Price: $#{@invoice_item_1.unit_price/ 100.to_f}")
        expect(page).to have_content("Status: #{@invoice_item_1.status}")
      end

      within("#item_#{@item_2.id}") do
        expect(page).to have_content("Item Name: #{@item_2.name}")
        expect(page).to have_content("Quantity: #{@invoice_item_2.quantity}")
        expect(page).to have_content("Unit Price: $#{@invoice_item_2.unit_price/ 100.to_f}")
        expect(page).to have_content("Status: #{@invoice_item_2.status}")
      end


    end
  end
end