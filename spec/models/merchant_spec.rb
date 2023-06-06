require "rails_helper"

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many :items }
  end

  describe "validations" do
    it { should validate_presence_of :name }
  end

  describe "class methods" do
    let!(:merchant_1) { create(:merchant, status: 0) }
    let!(:merchant_2) { create(:merchant) }
    let!(:merchant_3) { create(:merchant) }

    it "#all_enabled" do
      expect(Merchant.all_enabled).to eq([merchant_1])
    end

    it "#all_disabled" do
      expect(Merchant.all_disabled).to eq([merchant_2, merchant_3])
    end
  end

  describe "instance methods" do
    describe "#total_revenue" do
      it "returns total revenue for a merchant" do
        merchant_1 = create(:merchant)
        customer_1 = create(:customer)
        invoice_1 = create(:invoice, customer_id: customer_1.id)
        invoice_2 = create(:invoice, customer_id: customer_1.id)
        item_1 = create(:item, merchant_id: merchant_1.id)
        item_2 = create(:item, merchant_id: merchant_1.id)
        item_3 = create(:item, merchant_id: merchant_1.id)
        transaction_1 = create(:transaction, invoice_id: invoice_1.id, result: "success")
        transaction_2 = create(:transaction, invoice_id: invoice_2.id, result: "success")
        
        invoice_item_1 = create(:invoice_item, invoice_id: invoice_1.id, item_id: item_1.id, quantity: 10, unit_price: 1000)
        invoice_item_2 = create(:invoice_item, invoice_id: invoice_1.id, item_id: item_2.id, quantity: 1000, unit_price: 100)
        invoice_item_3 = create(:invoice_item, invoice_id: invoice_1.id, item_id: item_3.id, quantity: 50, unit_price: 500)

        invoice_item_4 = create(:invoice_item, invoice_id: invoice_2.id, item_id: item_1.id, quantity: 0, unit_price: 0)
        invoice_item_5= create(:invoice_item, invoice_id: invoice_2.id, item_id: item_2.id, quantity: 60, unit_price: 60)
        invoice_item_6 = create(:invoice_item, invoice_id: invoice_2.id, item_id: item_3.id, quantity: 50, unit_price: 40)

        expect(merchant_1.total_revenue).to eq(140600)
      end
    end
  end
end
