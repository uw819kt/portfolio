FactoryBot.define do
  factory :drive_af_log do
    check_time { Time.current }
    confirmation { 0 }
    detector_used { true }
    result { 0.00 }
    condition { 0 }
    log_remarks { "" }
    association :car
    association :user
  end
end
