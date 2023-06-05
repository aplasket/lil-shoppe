class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  validates_presence_of :name, :description, :unit_price

  enum status: ["disabled", "enabled"]

  def self.sort_enabled
    where(status: "enabled")
  end

  def self.sort_disabled
    where(status: "disabled")
  end
end

