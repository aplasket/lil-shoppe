FactoryBot.define do
  factory :transaction do
    credit_card_number { "MyString" }
    credit_card_expiration { "2023-05-31" }
    result { false }
    invoice { nil }
  end
end
