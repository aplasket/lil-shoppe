FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.words(number: 4) }
    unit_price { Faker::Number.within(range: 100..20000) }
    merchant
  end
end
