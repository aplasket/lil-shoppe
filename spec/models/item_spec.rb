require "rails_helper"

RSpec.describe Item, type: :model do
  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:customers).through(:invoices) }
  end

  describe "Instance Methods" do
    before (:each) do
      @merchant_1 = create(:merchant)
      @customer_1 = create(:customer)
      @customer_2 = create(:customer)
      @invoice_1 = create(:invoice, customer: @customer_1)
      @invoice_2 = create(:invoice, customer: @customer_2)
      @item_1 = create(:item, merchant: @merchant_1)
      @item_2 = create(:item, merchant: @merchant_1)
      @item_3 = create(:item, merchant: @merchant_1)
      @invoice_item_1 = create(:invoice_item, invoice: @invoice_1, item: @item_1)
      @invoice_item_2 = create(:invoice_item, invoice: @invoice_1, item: @item_2)
      @invoice_item_3 = create(:invoice_item, invoice: @invoice_2, item: @item_1)
      @invoice_item_4 = create(:invoice_item, invoice: @invoice_2, item: @item_3)
    end

    describe "#quantity_sold" do
      it "finds the quantity of the item sold in a paticular invoice" do
        expect(@item_1.quantity_sold(@invoice_1)).to eq([@invoice_item_1.quantity])
        expect(@item_2.quantity_sold(@invoice_1)).to eq([@invoice_item_2.quantity])
        expect(@item_1.quantity_sold(@invoice_2)).to eq([@invoice_item_3.quantity])
      end
    end

    describe "#find_sold_price" do
      it "finds the price the item sold for in a particular invoice_item" do
        expect(@item_1.find_sold_price(@invoice_1)).to eq([@invoice_item_1.unit_price])
        expect(@item_2.find_sold_price(@invoice_1)).to eq([@invoice_item_2.unit_price])
        expect(@item_1.find_sold_price(@invoice_2)).to eq([@invoice_item_3.unit_price])
      end
    end

    describe "#invoice_item_status" do
      it "finds the status of the item in a particular invoice_item" do
        expect(@item_1.invoice_item_status(@invoice_1)).to eq([@invoice_item_1.status])
        expect(@item_2.invoice_item_status(@invoice_1)).to eq([@invoice_item_2.status])
        expect(@item_1.invoice_item_status(@invoice_2)).to eq([@invoice_item_3.status])
      end
    end
  end
end


