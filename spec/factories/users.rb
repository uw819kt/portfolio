FactoryBot.define do
  factory :user do
    name { "manager" }
    email { "manager#{SecureRandom.hex(1)}@example.com" }
    department { 0 }
  end
end
