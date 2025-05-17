FactoryBot.define do
  factory :grant do
    granted_piece { 20 }
    granted_day { Date.new(Date.today.year, 4, 1) }
    association :paid_leave
    association :user
  end
end
