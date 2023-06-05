class Merchant < ApplicationRecord
  has_many :items

  def items_ready_to_ship
    items.joins(:invoices)
    .where("invoices.status = ?", 0)
    .select("items.*")
  end
end
