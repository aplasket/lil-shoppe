class Merchant < ApplicationRecord
  has_many :items
  
  enum status: [:enabled, :disabled]
end
