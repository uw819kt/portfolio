FactoryBot.define do
  factory :approval do
    request_date { Time.current }
    acquisition_date { Time.current + 7.days }
    paid_applicable { false }
    paid_confirm { false }
    paid_remarks { "" }
    association :paid_leave
    association :user
    association :request
  end
end
