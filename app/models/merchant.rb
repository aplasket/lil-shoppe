class Merchant < ApplicationRecord
  has_many :items
  validates_presence_of :name

  enum status: [:enabled, :disabled]

  def self.all_enabled
    where(status: 0)
  end

  def self.all_disabled
    where(status: 1)
  end
end
