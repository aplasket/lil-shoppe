require "rails_helper"

RSpec.describe "Merchant_items#index", type: :feature do
let!(:merchant_1) { Merchant.create!(name: "Steve's Soaps") }
let!(:merchant_2) { Merchant.create!(name: "Charlie's Chia Pets") }
let!(:item_1) { merchant_1.items.create!(name: "hand soap", description: "lavender", unit_price: 800, status: "enabled") }
let!(:item_2) { merchant_1.items.create!(name: "sugar scrub", description: "lemongrass", unit_price: 1000, status: "enabled") }
let!(:item_3) { merchant_2.items.create!(name: "Bob Ross Chia", description: "medium chia pet", unit_price: 1500, status: "disabled") }
let!(:item_4) { merchant_1.items.create!(name: "hand soap", description: "lavender", unit_price: 800, status: "enabled") }
let!(:item_5) { merchant_1.items.create!(name: "sugar scrub", description: "lemongrass", unit_price: 1000, status: "enabled") }
let!(:item_6) { merchant_2.items.create!(name: "Bob Ross Chia", description: "medium chia pet", unit_price: 1500, status: "disabled") }
let!(:item_7) { merchant_1.items.create!(name: "hand soap", description: "lavender", unit_price: 800, status: "enabled") }
let!(:item_8) { merchant_1.items.create!(name: "sugar scrub", description: "lemongrass", unit_price: 1000, status: "enabled") }
let!(:item_9) { merchant_2.items.create!(name: "Bob Ross Chia", description: "medium chia pet", unit_price: 1500, status: "disabled") }

let!(:customer1) { Customer.create!(first_name: "Shakira", last_name: "Shanana") }
let!(:customer2) { Customer.create!(first_name: "Cher", last_name: "Chernobyl") }

let!(:invoice1) { Invoice.create!(customer_id: customer1.id, status: 1) }
let!(:invoice2) { Invoice.create!(customer_id: customer1.id, status: 1) }
let!(:invoice3) { Invoice.create!(customer_id: customer1.id, status: 1) }
let!(:invoice4) { Invoice.create!(customer_id: customer2.id, status: 1) }

let!(:invoiceitem1) { InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice1.id, quantity: 100, unit_price: 10, status: 1) }
let!(:invoiceitem2) { InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice2.id, quantity: 100, unit_price: 11, status: 1) }
let!(:invoiceitem3) { InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice3.id, quantity: 100, unit_price: 12, status: 1) }
let!(:invoiceitem4) { InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice4.id, quantity: 10, unit_price: 12, status: 1) }
let!(:invoiceitem5) { InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice1.id, quantity: 100, unit_price: 11, status: 1) }
let!(:invoiceitem6) { InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice1.id, quantity: 100, unit_price: 12, status: 1) }
let!(:invoiceitem7) { InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice1.id, quantity: 100, unit_price: 15, status: 1) }
let!(:invoiceitem8) { InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice1.id, quantity: 100, unit_price: 1, status: 1) }

let!(:transaction1) { Transaction.create!(invoice_id: invoice1.id, cc_num: 456789456541 cc_exp: 82546789, result: 1) }

  it "shows all of the names of all of the merchant's items" do
    visit merchant_items_path(merchant_id: merchant_1.id)

    expect(page).to have_content(item_1.name)
    expect(page).to have_content(item_2.name)
    expect(page).to_not have_content(item_3.name)
  end

  it "displays a button that will enable or disable each item" do
    visit merchant_items_path(merchant_id: merchant_1.id)

    within ".enabled-items" do
      expect(page).to have_content("Enabled Items")
      expect(page).to have_link(item_1.name)
      expect(page).to have_link(item_2.name)

      expect(page).to have_button("Disable #{item_1.name}")
      expect(page).to have_button("Disable #{item_2.name}")

      click_button "Disable #{item_1.name}"
    end

    expect(current_path).to eq(merchant_items_path(merchant_id: merchant_1.id))

    within ".disabled-items" do
      expect(page).to have_content("Disabled Items")
      expect(page).to have_link(item_1.name)
      expect(page).to_not have_content(item_2.name)

      expect(page).to have_button("Enable #{item_1.name}")
      expect(page).to_not have_button("Disable #{item_2.name}")

      click_button "Enable #{item_1.name}"
    end

    within ".enabled-items" do
      expect(page).to_not have_link(item_3.name)
      expect(page).to_not have_button("Enable #{item_2.name}")
    end
  end

    # US 12
    # As a merchant
    # When I visit my items index page
    # Then I see the names of the top 5 most popular items ranked by total revenue generated
    # And I see that each item name links to my merchant item show page for that item
    # And I see the total revenue generated next to each item name

    # Notes on Revenue Calculation:
    # - Only invoices with at least one successful transaction should count towards revenue
    # - Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
    # - Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price)

    it "shows the most popular items" do
      within "#top-five" do

      end
    end





  end
