FactoryBot.define do
  factory :transaction do
    credit_card_number { Faker::Number.number(digits: 16) }
    credit_card_expiration_date { Faker::Date.between(from: "2023-06-01", to: "2028-12-31") }
    result { Faker::Boolean.boolean }
    invoice
  end
end
