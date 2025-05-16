FactoryBot.define do
  factory :paid_leave do
    joining_date { Time.current + 7.years }
    base_date { Date.new(Date.today.year, 4, 1) }
    part_time { false }
    classification { 0 }
    association :user
  end
end
