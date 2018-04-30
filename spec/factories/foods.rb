FactoryBot.define do
  factory :food do
    sequence(:name) { |n| "Food #{n}"}
    sequence(:calories) { |n| n }
  end
end
