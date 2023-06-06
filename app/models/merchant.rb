class Merchant < ApplicationRecord
  has_many :items

  enum status: [:enabled, :disabled]

  def self.all_enabled
    where(status: 0)
  end

  def self.all_disabled
    where(status: 1)
  end

  def items_ready_to_ship
    items.joins(:invoices)
    .where("invoices.status = ?", 0)
    .select("items.*")
  end
end
