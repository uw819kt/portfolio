FactoryBot.define do
  factory :user do
    name { "manager" }
    sequence(:email) { |n| "manager#{n}@example.com" }
    department { 0 }
  end

  factory :user_2, class: "user" do
    name { "normal_1" }
    sequence(:email) { |n| "normal#{n}@example.com" }
    department { 4 }
  end
end
