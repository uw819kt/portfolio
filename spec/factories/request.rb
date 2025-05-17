FactoryBot.define do
  factory :request do
    request_date { Time.current }
    acquisition_date { Time.current + 7.days }
    paid_remarks { "" }
    association :paid_leave
    association :user
  end

  factory :request_2, class: "request" do
    request_date { Time.current+ 2.days }
    acquisition_date { Time.current + 9.days }
    paid_remarks { "介護休暇" }
    association :paid_leave
    association :user
  end
end
