require "rails_helper"

RSpec.describe "Admin Invoices Show Page", type: :feature do
  describe "As an Admin, when I visit an admin invoice show page" do
    it "displays all the information related to that invoice" do
      merchant_1 = create(:merchant)
      customer_1 = create(:customer)
      customer_2 = create(:customer)
      invoice_1 = create(:invoice, customer: customer_1)
      invoice_2 = create(:invoice, customer: customer_2)

      visit "/admin/invoices/#{invoice_1.id}"
      
      expect(page).to have_content("Invoice ID: #{invoice_1.id}")
      expect(page).to have_content("Invoice Status: #{invoice_1.status}")
      expect(page).to have_content("Invoice Created On: #{invoice_1.created_at.strftime("%A, %B %d, %Y")}")
      expect(page).to have_content("Customer Name: #{customer_1.first_name} #{customer_1.last_name}")

      expect(page).to_not have_content("Invoice ID: #{invoice_2.id}")
      expect(page).to_not have_content("Customer Name: #{invoice_2.customer.first_name} #{invoice_2.customer.last_name}")

      visit "/admin/invoices/#{invoice_2.id}"

      expect(page).to have_content("Invoice ID: #{invoice_2.id}")
      expect(page).to have_content("Invoice Status: #{invoice_2.status}")
      expect(page).to have_content("Invoice Created On: #{invoice_2.created_at.strftime("%A, %B %d, %Y")}")
      expect(page).to have_content("Customer Name: #{customer_2.first_name} #{customer_2.last_name}")

      expect(page).to_not have_content("Invoice ID: #{invoice_1.id}")
      expect(page).to_not have_content("Customer Name: #{invoice_1.customer.first_name} #{invoice_1.customer.last_name}")
    end
  end
end