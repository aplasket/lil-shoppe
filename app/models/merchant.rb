class Merchant < ApplicationRecord
  has_many :items

  def items_ready_to_ship
    items.joins(:invoices)
    .where("invoices.status = ?", 1)
    .select("items.*")
  end
end
