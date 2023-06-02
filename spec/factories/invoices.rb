FactoryBot.define do
  factory :invoice do
    status { ["In Progress", "Completed", "Cancelled"].sample }
    customer
  end
end
