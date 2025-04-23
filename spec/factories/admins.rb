FactoryBot.define do
  factory :admin do
    name { "admin" }
    email { "admin#{SecureRandom.hex(1)}@aaa.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end
