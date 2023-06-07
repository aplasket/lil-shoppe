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
      expect(page).to have_content("Customer Name: #{@customer_1.first_name} #{@customer_1.last_name}")
    end
  end
end