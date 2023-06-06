require "rails_helper"

RSpec.describe Merchant, type: :model do
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
    
    expect(items_ready_to_ship).to include(item1)
    expect(items_ready_to_ship).not_to include(item2)
  end
end
