class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: ["in progress", "completed", "cancelled"]

  def self.find_and_sort_incomplete_invoices
    joins(:invoice_items).where("invoice_items.status != 2").group(:id).order(:created_at)
  end
end
