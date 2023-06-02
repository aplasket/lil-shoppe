class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def price_in_dollars
    sprintf("$%.2f", unit_price / 100.to_f)
  end
end
