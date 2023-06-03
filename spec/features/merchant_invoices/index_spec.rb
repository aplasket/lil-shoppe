require "rails_helper"

RSpec.describe "Merchant Invoices Index" do
  let!(:merchant_1) { Merchant.create!(name: "Steve's Soaps") }
  let!(:merchant_2) { Merchant.create!(name: "Charlie's Chia Pets") }

  let!(:item_1) { merchant_1.items.create!(name: "hand soap", description: "lavender", unit_price: 800) }
  let!(:item_2) { merchant_1.items.create!(name: "sugar scrub", description: "lemongrass", unit_price: 1000) }
  let!(:item_3) { merchant_2.items.create!(name: "Bob Ross Chia", description: "medium chia pet", unit_price: 1500) }

  let!(:customer_1) { Customer.create!(first_name: "Joseph", last_name: "Biden") }

  let!(:invoice_1) { Invoice.create!(customer_id: customer_1.id, status: "completed") }
  let!(:invoice_2) { Invoice.create!(customer_id: customer_1.id, status: "completed") }
  let!(:invoice_3) { Invoice.create!(customer_id: customer_1.id, status: "completed") }

  let!(:invoice_item_1) { InvoiceItem.create!(quantity: 1, unit_price: 800, status: "pending", item_id: item_1.id, invoice_id: invoice_1.id) }
  let!(:invoice_item_2) { InvoiceItem.create!(quantity: 2, unit_price: 2000, status: "pending", item_id: item_2.id, invoice_id: invoice_1.id) }
  let!(:invoice_item_3) { InvoiceItem.create!(quantity: 1, unit_price: 1000, status: "pending", item_id: item_2.id, invoice_id: invoice_2.id) }
  let!(:invoice_item_4) { InvoiceItem.create!(quantity: 1, unit_price: 1500, status: "pending", item_id: item_3.id, invoice_id: invoice_2.id) }
  let!(:invoice_item_5) { InvoiceItem.create!(quantity: 1, unit_price: 1500, status: "pending", item_id: item_3.id, invoice_id: invoice_3.id) }

  it "shows all of the invoices that include at least one of my merchant's items" do
    visit "/merchants/#{merchant_1.id}/invoices"

    expect(page).to have_content("Invoices for #{merchant_1.name}")

    expect(page).to have_link("#{invoice_1.id}")
  end
end
