FactoryBot.define do
  factory :invoice_item do
    item
    invoice
    quantity { Faker::Number.number(digits: 3) }
    unit_price { Faker::Number.within(range: 100..20000) }
    status { ["Pending", "Packaged", "Shipped"].sample }
  end
end
