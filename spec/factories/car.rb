FactoryBot.define do
  factory :car do
    company_car { "下関111あ1111" }
    private_car { "" }
    association :user
  end
end
