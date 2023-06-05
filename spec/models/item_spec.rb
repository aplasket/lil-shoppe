require "rails_helper"

RSpec.describe Item, type: :model do
  it { should belong_to :merchant }
  it { should have_many :invoice_items }
  it { should have_many(:invoices).through(:invoice_items) }

  let!(:merchant_1) { create(:merchant) }
  let!(:merchant_2) { create(:merchant) }

  let!(:item_1) { create(:item, merchant_id: merchant_1.id, status: 0)}
  let!(:item_2) { create(:item, merchant_id: merchant_1.id, status: 1)}
  let!(:item_3) { create(:item, merchant_id: merchant_1.id, status: 1)}

  describe "class methods" do
    describe "#sort_enabled" do
      it "sorts the items by the enabled status" do
        expect(merchant_1.items.sort_enabled).to eq([item_2, item_3])
      end
    end

    describe "#sort_disabled" do
      it "sorts the items by disabled status" do
        expect(merchant_1.items.sort_disabled).to eq([item_1])
      end
    end
  end
end