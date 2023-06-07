class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def quantity_sold(invoice)
    invoice_items.where(invoice_id: invoice.id).pluck(:quantity)
  end

  def find_sold_price(invoice)
    invoice_items.where(invoice_id: invoice.id).pluck(:unit_price)
  end

  def invoice_item_status(invoice)
    invoice_items.where(invoice_id: invoice.id).pluck(:status)
  end
  validates_presence_of :name, :description, :unit_price

  enum status: ["enabled", "disabled"]

  def self.sort_enabled
    where(status: "enabled")
  end

  def self.sort_disabled
    where(status: "disabled")
  end

  def self.top_item_revenue
    joins(invoices: :transactions)
    .select("items.*, sum(invoice_items.unit_price * invoice_items.quantity) AS total_revenue")
    .where("transactions.result = 0")
    .group("items.id")
    .order("total_revenue desc")
    .limit(5)

  def item_rev
    
  end
end

