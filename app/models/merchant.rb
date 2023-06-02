class Merchant < ApplicationRecord
  has_many :items

  # def merchant_items_path(@merchant.id)
  #   items_path(@merchant.id)
  # end

  # def merchant_invoices_path(@merchant.id)
  # invoices_path(@merchant.id)
  # end
end
