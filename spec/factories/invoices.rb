FactoryBot.define do
  factory :invoice do
    status { 1 }
    customer
  end
end
