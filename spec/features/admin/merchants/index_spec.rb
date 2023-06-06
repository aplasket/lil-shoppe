require "rails_helper"

RSpec.describe "/admin/merchants, admin::merchants index page" do
  let!(:merchant_1) { create(:merchant, status: 0) }
  let!(:merchant_2) { create(:merchant) }
  let!(:merchant_3) { create(:merchant) }

  describe "as an admin on the admin::merchants index page" do
    it "I see the name of each merchant and their links - US24" do
      visit admin_merchants_path

      within ".merchant-#{merchant_1.id}" do
        expect(page).to have_link(merchant_1.name)
      end

      within ".merchant-#{merchant_2.id}" do
        expect(page).to have_link(merchant_2.name)
      end
    end

    it "shows a button to enable/disable a merchant - US27" do
      visit admin_merchants_path

      within ".merchant-#{merchant_1.id}" do
        expect(merchant_1.status).to eq("enabled")
        expect(page).to have_button("Disable")
      end

      within ".merchant-#{merchant_2.id}" do
        expect(merchant_2.status).to eq("disabled")
        expect(page).to have_button("Enable")
      end
    end

    it "updates status of given merchant when clicked - US27" do
      visit admin_merchants_path

      expect(merchant_1.status).to eq("enabled")
      expect(merchant_2.status).to eq("disabled")
      expect(merchant_3.status).to eq("disabled")

      within ".merchant-#{merchant_1.id}" do
        expect(page).to have_button("Disable")
        expect(page).to_not have_button("Enable")

        click_button "Disable"

        expect(current_path).to eq(admin_merchants_path)
        expect(page).to have_button("Enable")
      end

      within ".merchant-#{merchant_2.id}" do
        expect(page).to have_button("Enable")
        expect(page).to_not have_button("Disable")

        click_button "Enable"

        expect(current_path).to eq(admin_merchants_path)
        expect(page).to have_button("Disable")
      end

      expect(page).to have_content("Merchant status updated successfully")
      expect(merchant_1.reload.status).to eq("disabled")
      expect(merchant_2.reload.status).to eq("enabled")
      expect(merchant_3.reload.status).to eq("disabled")
    end

    it "shows sections for enabled/disabled merchants - US28" do
      visit admin_merchants_path

      within "#enabled-merchants" do
        within ".merchant-#{merchant_1.id}" do
          expect(merchant_1.status).to eq("enabled")
          expect(page).to have_button("Disable")
        end
      end

      within "#disabled-merchants" do
        within ".merchant-#{merchant_2.id}" do
          expect(merchant_2.status).to eq("disabled")
          expect(page).to have_button("Enable")
        end

        within ".merchant-#{merchant_3.id}" do
          expect(merchant_3.status).to eq("disabled")
          expect(page).to have_button("Enable")
        end
      end
    end

    it "shows a link to create a new merchant - US29" do
      visit admin_merchants_path

      expect(page).to have_link("Create New Merchant")

      click_link("Create New Merchant")

      expect(current_path).to eq(new_admin_merchant_path)
    end
  end

  describe "admin::merchants index page - top 5 merchants by revenue" do
    #merchants & items
    let!(:merchant_1) { create(:merchant, status: 0) }
    let!(:item_1) { create(:item, merchant: merchant_1, status: 1)}

    let!(:merchant_2) { create(:merchant) status: 0}
    let!(:item_2) { create(:item, merchant: merchant_2, status: 1)}

    let!(:merchant_3) { create(:merchant) status: 0}
    let!(:item_3) { create(:item, merchant: merchant_3, status: 1)}

    let!(:merchant_4) { create(:merchant) status: 0}
    let!(:item_4) { create(:item, merchant: merchant_4, status: 1)}

    let!(:merchant_5) { create(:merchant) status: 0}
    let!(:item_5) { create(:item, merchant: merchant_5, status: 1)}

    let!(:merchant_6) { create(:merchant) status: 0}
    let!(:item_6) { create(:item, merchant: merchant_6, status: 1)}

    #customers & associated invoices & their transactions:
    let!(:customer_1) { create(:customer) }
    let!(:invoice_1) { create(:invoice, customer: customer_1, status: 0)}
    let!(:transaction_1) { create(:transaction, invoice_id: invoice_1.id, result: "success") }

    let!(:invoice_3) { create(:invoice, customer: customer_1, status: 0)}
    let!(:transaction_3) { create(:transaction, invoice_id: invoice_3.id, result: "failed") }

    let!(:customer_2) { create(:customer) }
    let!(:invoice_2) { create(:invoice, customer: customer_2, status: 0)}
    let!(:transaction_2) { create(:transaction, invoice_id: invoice_2.id, result: "success") }

    let!(:customer_3) { create(:customer) }
    let!(:invoice_4) { create(:invoice, customer: customer_3, status: 0)}
    let!(:transaction_4) { create(:transaction, invoice_id: invoice_4.id, result: "failed") }

    #invoice_items
    let!(:invoice_item_1) { create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, quantity: 240, unit_price: 100, status: 0)}
    let!(:invoice_item_2) { create(:invoice_item, item_id: item_2.id, invoice_id: invoice_1.id, quantity: 12, unit_price: 2000, status: 0)}
    let!(:invoice_item_3) { create(:invoice_item, item_id: item_3.id, invoice_id: invoice_1.id, quantity: 25, unit_price: 1000, status: 0)}
    let!(:invoice_item_4) { create(:invoice_item, item_id: item_4.id, invoice_id: invoice_2.id, quantity: 150, unit_price: 3000, status: 0)}
    let!(:invoice_item_5) { create(:invoice_item, item_id: item_5.id, invoice_id: invoice_2.id, quantity: 10, unit_price: 500, status: 0)}
    let!(:invoice_item_6) { create(:invoice_item, item_id: item_6.id, invoice_id: invoice_2.id, quantity: 20, unit_price: 1000, status: 0)}
    let!(:invoice_item_7) { create(:invoice_item, item_id: item_1.id, invoice_id: invoice_3.id, quantity: 20, unit_price: 1000, status: 0)}
    let!(:invoice_item_8) { create(:invoice_item, item_id: item_2.id, invoice_id: invoice_4.id, quantity: 20, unit_price: 1000, status: 0)}



    xit "shows links and names of top 5 merchants by revenue - US30" do
      # As an admin,
      # When I visit the admin merchants index (/admin/merchants)
      # Then I see the names of the top 5 merchants by total revenue generated
      # And I see that each merchant name links to the admin merchant show page for that merchant
      # And I see the total revenue generated next to each merchant name

      # Notes on Revenue Calculation:
      # - Only invoices with at least one successful transaction should count towards revenue
      # - Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
      # - Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price)

      visit admin_merchants_path

      expect(page).to have_content("Top 5 Merchants")

      within "#top-5-merchants" do
        expect(page).to have_link()
        expect(page).to have_link()
        expect(page).to have_link()
        expect(page).to have_link()
        expect(page).to have_link()

        expect(page).to_not have_content()
      end
    end

    xit "each link takes me to the admin merchant show page - US30" do
      visit admin_merchants_path

      within "#top-5-merchants" do
        click_link()
        expect(current_path).to eq(admin_merchant_path())
      end
    end

    xit "displays total revenue generated next to each merchant name - US30" do
      visit admin_merchants_path

      within "#top-5-merchants" do
        expect(page).to have_content("Total Revenue: $_ ")
        expect(page).to have_content("Total Revenue: $_ ")
        expect(page).to have_content("Total Revenue: $_ ")
        expect(page).to have_content("Total Revenue: $_ ")
        expect(page).to have_content("Total Revenue: $_ ")
      end
    end
  end
end
