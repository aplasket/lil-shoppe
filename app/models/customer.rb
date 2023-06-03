class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items

  def self.top_5_by_transaction
    select("customers.*, count(transactions.id) as result_count").joins(:transactions).where("transactions.result = true").group(:id).order(result_count: :desc).limit(5)
  end

  def successful_transactions_count
    transactions.where(result: "true").count
  end
end
