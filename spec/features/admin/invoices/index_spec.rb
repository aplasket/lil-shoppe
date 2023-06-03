require "rails_helper"

RSpec.describe "Admin Invoices Index Page", type: :feature do
  before(:each) do
    @customer_1 = create(:customer)
    @invoice_1 = create(:invoice, customer_id: @customer_1.id)
    @invoice_2 = create(:invoice, customer_id: @customer_1.id)
    @invoice_3 = create(:invoice, customer_id: @customer_1.id)
  end
  describe "As an Admin, when I visit the Admin Invoices Index page" do
    it "displays all Invoice IDs in the system" do
      visit "/admin/invoices"

      expect(page).to have_content("All Invoices")
      expect(page).to have_content(@invoice_1.id)
      expect(page).to have_content(@invoice_2.id)
      expect(page).to have_content(@invoice_3.id)
    end
    it "Each ID links to admin invoice show page" do
      visit "/admin/invoices"

      expect(page).to have_link("#{@invoice_1.id}")
      click_link("#{@invoice_1.id}")
      expect(current_path).to eq("/admin/invoices/#{@invoice_1.id}")

      visit admin_invoices_path
      expect(page).to have_link("#{@invoice_2.id}")
      click_link("#{@invoice_2.id}")
      expect(current_path).to eq("/admin/invoices/#{@invoice_2.id}")

      visit admin_invoices_path
      expect(page).to have_link("#{@invoice_3.id}")
      click_link("#{@invoice_3.id}")
      expect(current_path).to eq("/admin/invoices/#{@invoice_3.id}")
    end
  end
end