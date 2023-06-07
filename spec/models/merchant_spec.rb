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
end
