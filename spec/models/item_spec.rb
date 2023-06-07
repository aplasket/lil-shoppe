require "rails_helper"

RSpec.describe Item, type: :model do
  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:customers).through(:invoices) }
  end

  describe "Class Methods" do

    let!(:merchant_1) { create(:merchant) }
    let!(:merchant_2) { create(:merchant) }

    let!(:customer_1) { create(:customer) }
    let!(:customer_2) { create(:customer) }

    let!(:item_1) { create(:item, merchant: merchant_1, status: 'disabled') }
    let!(:item_2) { create(:item, merchant: merchant_2, status: 'enabled') }
    let!(:item_3) { create(:item, merchant: merchant_1, status: 'enabled') }
    let!(:item_4) { create(:item, merchant: merchant_2, status: 'enabled') }
    let!(:item_5) { create(:item, merchant: merchant_1, status: 'disabled') }
    let!(:item_6) { create(:item, merchant: merchant_2, status: 'enabled') }
    let!(:item_7) { create(:item, merchant: merchant_1, status: 'disabled') }
    let!(:item_8) { create(:item, merchant: merchant_2, status: 'enabled') }

    let!(:invoice_1) { create(:invoice, customer: customer_1) }
    let!(:invoice_2) { create(:invoice, customer: customer_2) }

    let!(:invoice_item_1) { create(:invoice_item, invoice: invoice_1, item: item_1, quantity: 5, unit_price: 100) }
    let!(:invoice_item_2) { create(:invoice_item, invoice: invoice_1, item: item_3, quantity: 3, unit_price: 150) }
    let!(:invoice_item_3) { create(:invoice_item, invoice: invoice_1, item: item_5, quantity: 2, unit_price: 200) }
    let!(:invoice_item_4) { create(:invoice_item, invoice: invoice_2, item: item_2, quantity: 4, unit_price: 120) }
    let!(:invoice_item_5) { create(:invoice_item, invoice: invoice_2, item: item_4, quantity: 6, unit_price: 180) }
    let!(:invoice_item_6) { create(:invoice_item, invoice: invoice_1, item: item_7, quantity: 1, unit_price: 250) }
    let!(:invoice_item_7) { create(:invoice_item, invoice: invoice_2, item: item_6, quantity: 2, unit_price: 160) }
    let!(:invoice_item_8) { create(:invoice_item, invoice: invoice_2, item: item_8, quantity: 3, unit_price: 140) }

    describe "#quantity_sold" do
      it "finds the quantity of the item sold in a particular invoice" do
        expect(item_1.quantity_sold(invoice_1)).to eq([5])
        expect(item_3.quantity_sold(invoice_1)).to eq([3])
        expect(item_2.quantity_sold(invoice_2)).to eq([4])
      end
    end

    describe "#find_sold_price" do
      it "finds the price the item sold for in a particular invoice_item" do
        expect(item_1.find_sold_price(invoice_1)).to eq([100])
        expect(item_2.find_sold_price(invoice_1)).to eq([])
        expect(item_4.find_sold_price(invoice_2)).to eq([180])
      end
    end

    describe "#invoice_item_status" do
      it "finds the status of the item in a particular invoice_item" do
        expect(item_1.invoice_item_status(invoice_1)).to eq([invoice_item_1.status])
        expect(item_2.invoice_item_status(invoice_2)).to eq([invoice_item_4.status])
        expect(item_3.invoice_item_status(invoice_1)).to eq([invoice_item_2.status])
      end
    end

    describe "#sort_enabled" do
      it "sorts the items by the enabled status" do
        expect(merchant_1.items.sort_enabled).to eq([item_3])
      end
    end

    describe "#sort_disabled" do
      it "sorts the items by disabled status" do
        expect(merchant_1.items.sort_disabled).to eq([item_1, item_5, item_7])
      end
    end
  end
end

    # describe "#top-5" do
    #   it "revenue method" do
    #     expect(@merchant1.items.revenue).to eq([@item5, @item3, @item2, @item1, @item6])
    #   end
    #   it "item_revenue method" do
    #     expect(@item1.item_rev_dollars).to eq(1000)
    #   end
    # end
