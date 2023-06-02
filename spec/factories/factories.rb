FactoryBot.define do
  factory :customer do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end

  factory :invoice_item do
    item
    invoice
    quantity { Faker::Number.number(digits: 3) }
    unit_price { Faker::Number.within(range: 100..20000) }
    status { ["pending", "packaged", "shipped"].sample }
  end

  factory :invoice do
    status { ["in progress", "completed", "cancelled"].sample }
    customer
  end

  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.words(number: 4) }
    unit_price { Faker::Number.within(range: 100..20000) }
    merchant
  end

  factory :merchant do
    name { Faker::Company.name }
  end

  factory :transaction do
    credit_card_number { Faker::Number.number(digits: 16) }
    credit_card_expiration_date { Faker::Date.between(from: "2023-06-01", to: "2028-12-31") }
    result { Faker::Boolean.boolean }
    invoice
  end
end
