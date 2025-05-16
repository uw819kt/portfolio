FactoryBot.define do
  factory :car do
    company_car { "下関111あ1111" }
    private_car { "" }
    association :user
  end

  factory :car_2, class: "car" do
    company_car { "11dle55Ac" }
    private_car { "" }
    association :user
  end
end
