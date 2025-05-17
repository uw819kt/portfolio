FactoryBot.define do
  factory :user do
    name { "manager" }
    sequence(:email) { |n| "manager#{n}@example.com" }
    department { 0 }
  end
end
