require "rails_helper"

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many :items }
  end

  describe "class methods" do
    let!(:merchant_1) { create(:merchant) }
    let!(:merchant_2) { create(:merchant, status: 1) }
    let!(:merchant_3) { create(:merchant, status: 1) }

    it "#all_enabled" do
      expect(Merchant.all_enabled).to eq([merchant_1])
    end

    it "#all_disabled" do
      expect(Merchant.all_disabled).to eq([merchant_2, merchant_3])
    end
  end
end
