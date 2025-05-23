require "set" # 重複しないコレクションを作る
# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# admin
User.create!(
  name: "manager",
  email: "manager@example.com",
  department: 0,
  is_admin: true
)

15.times do |n|
  User.create!(
    name: "normal_#{n + 1}",
    email: "normal#{n + 1}@example.com",
    department: rand(0..5),
    is_admin: false
  )
end


user_ids = User.pluck(:id)
user_ids_copy = user_ids.shuffle.dup

3.times do |n|
  classification_number = "%03d" % rand(0..999)
  serial_number = "%04d" % rand(0..9999)
  user_ids_copy = user_ids.shuffle.dup
  user_id = user_ids_copy.shift

  Car.create!(
    company_car: "下関#{classification_number}た#{serial_number}",
    private_car: "",
    user_id: user_id
  )
end

3.times do |n|
  classification_number = "%03d" % rand(0..999)
  serial_number = "%04d" % rand(0..9999)
  user_ids_copy = user_ids.shuffle.dup
  user_id = user_ids_copy.shift

  Car.create!(
    company_car: "",
    private_car: "下関#{classification_number}み#{serial_number}",
    user_id: user_id
  )
end

# フルタイム社員
13.times do |n|
  user_ids_copy = user_ids.shuffle.dup
  user_id = user_ids_copy.shift

  PaidLeave.create!(
    joining_date: rand(3..10).years.ago.change(month: 4, day: 1),
    base_date: Date.current.change(month: 4, day: 1),
    part_time: false,
    classification: 0,
    user_id: user_id
  )
end

# パートタイム社員
3.times do |n|
  user_ids_copy = user_ids.shuffle.dup
  user_id = user_ids_copy.shift

  PaidLeave.create!(
    joining_date: rand(3..10).years.ago.change(month: 4, day: 1),
    base_date: Date.current.change(month: 4, day: 1),
    part_time: true,
    classification: rand(1..4),
    user_id: user_id
  )
end

13.times do
  user_ids_copy = user_ids.shuffle.dup
  user_id = user_ids_copy.shift
  paid_leave_id = PaidLeave.find_by(user_id: user_id)&.id
  next unless paid_leave_id

  Grant.create!(
    granted_piece: rand(1..20),
    granted_day: Date.current.change(month: 4, day: 1),
    user_id: user_id,
    paid_leave_id: paid_leave_id
  )
end

# 普通の有給
10.times do |n|
  start_date = Date.new(Date.current.year, 4, 1)
  end_date = Date.new(Date.current.year + 1, 3, 31)
  random_date = rand(start_date..end_date)

  begin_date = random_date
  limit_date = random_date.next_month
  random_within_month = rand(begin_date..limit_date)

  user_id = user_ids_copy.shift
  paid_leave_id = PaidLeave.find_by(user_id: user_id)&.id
  next unless paid_leave_id

  Request.create!(
    request_date: random_date,
    acquisition_date: random_within_month,
    user_id: user_ids.sample,
    paid_leave_id: paid_leave_id,
    paid_remarks: ""
  )
end

# 特別有給
5.times do |n|
  start_date = Date.new(Date.current.year, 4, 1)
  end_date = Date.new(Date.current.year + 1, 3, 31)
  random_date = rand(start_date..end_date)

  begin_date = random_date
  limit_date = random_date.next_month
  random_within_month = rand(begin_date..limit_date)

  user_id = user_ids_copy.shift
  paid_leave_id = PaidLeave.find_by(user_id: user_id)&.id
  next unless paid_leave_id

  Request.create!(
    request_date: random_date,
    acquisition_date: random_within_month,
    user_id: user_ids.sample,
    paid_leave_id: paid_leave_id,
    paid_remarks: "特別休暇"
  )
end

car_ids = Car.pluck(:id)
existing_logs = Set.new

# 運転前
45.times do
  user_id = user_ids.sample
  date = rand(Date.current.beginning_of_month..Date.current.end_of_month)

  # 同じユーザーで同じ日付のレコードがすでにあればスキップ
  next if DriveBeLog.exists?(user_id: user_id, check_time: date..date.end_of_day)

  DriveBeLog.create!(
    check_time: date,
    confirmation: rand(0..2),
    detector_used: [ true, false ].sample,
    result: rand(0.0..0.10),
    condition: rand(0..2),
    log_remarks: "",
    car_id: car_ids.sample,
    user_id: user_id
  )
end

5.times do
  user_id = user_ids.sample
  date = rand(Date.current.beginning_of_month..Date.current.end_of_month)

  next if DriveBeLog.exists?(user_id: user_id, check_time: date..date.end_of_day)

  DriveBeLog.create!(
    check_time: date,
    confirmation: rand(0..2),
    detector_used: [ true, false ].sample,
    result: rand(0.0..0.10),
    condition: rand(0..2),
    log_remarks: "体調不良",
    car_id: car_ids.sample,
    user_id: user_id
  )
end

# 運転後
45.times do
  user_id = user_ids.sample
  date = rand(Date.current.beginning_of_month..Date.current.end_of_month)

  next if DriveAfLog.exists?(user_id: user_id, check_time: date..date.end_of_day)

  DriveAfLog.create!(
    check_time: date,
    confirmation: rand(0..2),
    detector_used: [ true, false ].sample,
    result: rand(0.0..0.10),
    condition: rand(0..2),
    log_remarks: "",
    car_id: car_ids.sample,
    user_id: user_id
  )
end

5.times do
  user_id = user_ids.sample
  date = rand(Date.current.beginning_of_month..Date.current.end_of_month)

  next if DriveAfLog.exists?(user_id: user_id, check_time: date..date.end_of_day)

  DriveAfLog.create!(
    check_time: date,
    confirmation: rand(0..2),
    detector_used: [ true, false ].sample,
    result: rand(0.0..0.10),
    condition: rand(0..2),
    log_remarks: "体調不良",
    car_id: car_ids.sample,
    user_id: user_id
  )
end
