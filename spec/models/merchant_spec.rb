require "rails_helper"

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many :items }
  
  it "returns items that are ready to be shipped" do
    merchant = create(:merchant)
    item1 = create(:item, merchant: merchant)
    item2 = create(:item, merchant: merchant)
    invoice1 = create(:invoice, status: 0)
    invoice2 = create(:invoice, status: 1)
    invoice3 = create(:invoice, status: 2)
    create(:invoice_item, item: item1, invoice: invoice1)
    create(:invoice_item, item: item2, invoice: invoice2)
        
    items_ready_to_ship = Item.joins(:invoices).where("invoices.status = ?", 0).select("items.*")
    
    expect(merchant.items_ready_to_ship).to include(item1)
    expect(merchant.items_ready_to_ship).not_to include(item2)
  end
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
end
