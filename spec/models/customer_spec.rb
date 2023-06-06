require "rails_helper"

RSpec.describe Customer, type: :model do
  describe "relationships" do
    it { should have_many :invoices }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:invoice_items).through(:invoices) }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe "class methods" do
    describe "#top_5_by_transaction" do
      let!(:customer_1) { create(:customer) } # 5 successful transactions
      let!(:customer_2) { create(:customer) } # 4 successful transactions
      let!(:customer_3) { create(:customer) } # 3 successful transactions
      let!(:customer_4) { create(:customer) } # _ successful transactions
      let!(:customer_5) { create(:customer) } # _1 successful transactions
      let!(:customer_6) { create(:customer) } # _0 successful transactions__

      before(:each) do
        5.times do
          invoice = create(:invoice, customer: customer_1)
          create(:transaction, result: true, invoice: invoice)
        end

        4.times do
          invoice = create(:invoice, customer: customer_2)
          create(:transaction, result: true, invoice: invoice)
        end

        3.times do
          invoice = create(:invoice, customer: customer_3)
          create(:transaction, result: true, invoice: invoice)
        end

        2.times do
          invoice = create(:invoice, customer: customer_4)
          create(:transaction, result: true, invoice: invoice)
        end

        invoice = create(:invoice, customer: customer_5)
        create(:transaction, result: true, invoice: invoice)
        create(:transaction, result: false, invoice: invoice)

        2.times do
          invoice = create(:invoice, customer: customer_6)
          create(:transaction, result: false, invoice: invoice)
        end
      end

        it "returns the 5 customers with the largest number of successful transactions" do
          expect(Customer.top_5_by_transaction).to eq([customer_1, customer_2, customer_3, customer_4, customer_5])
        end      
    end
  end

  describe "instance methods" do
    describe "#successful_transactions_count" do
      it "returns a count of a customers successful transactions" do
        customer_7 = create(:customer)
        customer_8 = create(:customer)

        5.times do
          invoice = create(:invoice, customer: customer_7)
          create(:transaction, result: true, invoice: invoice)
        end

        2.times do
          invoice = create(:invoice, customer: customer_8)
          create(:transaction, result: false, invoice: invoice)
        end

        expect(customer_7.successful_transactions_count).to eq(5)
        expect(customer_8.successful_transactions_count).to eq(0)
      end
    end
  end
end
