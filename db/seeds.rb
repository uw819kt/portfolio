# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


manager = User.create!( # arima
  name: "manager",
  email: "manager@example.com",
  department: 0,
  is_admin: true
)

normal_1 = User.create!( # hamsaki
  name: "normal_1",
  email: "normal_1@example.com",
  department: 0,
  is_admin: false
)

normal_2 = User.create!( # taguti
  name: "normal_2",
  email: "normal_2@example.com",
  department: 1,
  is_admin: false
)

normal_3 = User.create!( # etou
  name: "normal_3",
  email: "normal_3@example.com",
  department: 1,
  is_admin: false
)

normal_4 = User.create!( # akimoto
  name: "normal_4",
  email: "normal_4@example.com",
  department: 2,
  is_admin: false
)

normal_5 = User.create!( # isihara
  name: "normal_5",
  email: "normal_5@example.com",
  department: 3,
  is_admin: false
)

normal_6 = User.create!( # matubara
  name: "normal_6",
  email: "normal_6@example.com",
  department: 1,
  is_admin: false
)

normal_7 = User.create!( # kawata
  name: "normal_7",
  email: "normal_7@example.com",
  department: 3,
  is_admin: false
)

normal_8 = User.create!( # tutiya
  name: "normal_8",
  email: "normal_8@example.com",
  department: 3,
  is_admin: false
)

normal_9 = User.create!( # hurutani
  name: "normal_9",
  email: "normal_9@example.com",
  department: 4,
  is_admin: false
)

normal_10 = User.create!( # simizu
  name: "normal_10",
  email: "normal_10@example.com",
  department: 4,
  is_admin: false
)

normal_11 = User.create!( # asano
  name: "normal_11",
  email: "normal_11@example.com",
  department: 5,
  is_admin: false
)

normal_12 = User.create!( # nakayama
  name: "normal_12",
  email: "normal_12@example.com",
  department: 5,
  is_admin: false
)

manager_car = Car.create( # arima
  company_car: "下関430た5533",
  private_car: "",
  user_id: manager.id
)

normal_car_1 = Car.create( # hamasaki
  company_car: "",
  private_car: "下関430つ5533",
  user_id: normal_1.id
)

normal_car_2 = Car.create( # taguti
  company_car: "",
  private_car: "下関430と5533",
  user_id: normal_2.id
)

normal_car_3 = Car.create( # etou
  company_car: "",
  private_car: "下関430て5533",
  user_id: normal_3.id
)

normal_car_4 = Car.create( # akimoto
  company_car: "",
  private_car: "",
  user_id: normal_4.id
)

normal_car_5 = Car.create( # isihara
  company_car: "",
  private_car: "",
  user_id: normal_5.id
)

normal_car_6 = Car.create( # matubara
  company_car: "",
  private_car: "下関430な5533",
  user_id: normal_6.id
)

normal_car_7 = Car.create( # kawata
  company_car: "",
  private_car: "",
  user_id: normal_7.id
)

normal_car_8 = Car.create( # tutiya
  company_car: "",
  private_car: "",
  user_id: normal_8.id
)

normal_car_9 = Car.create( # hurutani
  company_car: "",
  private_car: "",
  user_id: normal_9.id
)

normal_car_10 = Car.create( # shimizu
  company_car: "",
  private_car: "",
  user_id: normal_10.id
)

normal_car_11 = Car.create( # asano
  company_car: "下関483あ5533",
  private_car: "",
  user_id: normal_11.id
)

normal_car_12 = Car.create( # nakayama
  company_car: "",
  private_car: "",
  user_id: normal_12.id
)

manager_pl_1 = PaidLeave.create!( # arima
  joining_date: 7.years.ago.change(month: 4, day: 1),
  base_date: 7.years.ago.change(month: 4, day: 1),
  part_time: false,
  classification: 0,
  user_id: manager.id
)

normal_pl_1 = PaidLeave.create!( # hamasaki
  joining_date: 7.years.ago.change(month: 4, day: 1),
  base_date: 7.years.ago.change(month: 4, day: 1),
  part_time: false,
  classification: 0,
  user_id: normal_1.id
)

normal_pl_2 = PaidLeave.create( # taguti
  joining_date: 7.years.ago.change(month: 4, day: 1),
  base_date: 7.years.ago.change(month: 4, day: 1),
  part_time: false,
  classification: 0,
  user_id: normal_2.id
)

normal_pl_3 = PaidLeave.create( # etou
  joining_date: 7.years.ago.change(month: 4, day: 1),
  base_date: 7.years.ago.change(month: 4, day: 1),
  part_time: false,
  classification: 0,
  user_id: normal_3.id
)

normal_pl_4 = PaidLeave.create( # akimoto
  joining_date: 7.years.ago.change(month: 4, day: 1),
  base_date: 7.years.ago.change(month: 4, day: 1),
  part_time: false,
  classification: 0,
  user_id: normal_4.id
)
normal_pl_5 = PaidLeave.create( # isihara
  joining_date: 7.years.ago.change(month: 4, day: 1),
  base_date: 7.years.ago.change(month: 4, day: 1),
  part_time: false,
  classification: 0,
  user_id: normal_5.id
)

normal_pl_6 = PaidLeave.create( # matubara
  joining_date: 7.years.ago.change(month: 4, day: 1),
  base_date: 7.years.ago.change(month: 4, day: 1),
  part_time: false,
  classification: 0,
  user_id: normal_6.id
)

normal_pl_7 = PaidLeave.create( # kawata
  joining_date: 7.years.ago.change(month: 4, day: 1),
  base_date: 7.years.ago.change(month: 4, day: 1),
  part_time: false,
  classification: 0,
  user_id: normal_7.id
)

normal_pl_8 = PaidLeave.create( # tutiya
  joining_date: 7.years.ago.change(month: 4, day: 1),
  base_date: 7.years.ago.change(month: 4, day: 1),
  part_time: false,
  classification: 0,
  user_id: normal_8.id
)

normal_pl_9 = PaidLeave.create( # hurutani
  joining_date: 7.years.ago.change(month: 4, day: 1),
  base_date: 7.years.ago.change(month: 4, day: 1),
  part_time: false,
  classification: 0,
  user_id: normal_9.id
)

normal_pl_10 = PaidLeave.create( # simizu
  joining_date: 7.years.ago.change(month: 4, day: 1),
  base_date: 7.years.ago.change(month: 4, day: 1),
  part_time: true,
  classification: 1,
  user_id: normal_10.id
)

normal_pl_11 = PaidLeave.create( # asano
  joining_date: 7.years.ago.change(month: 4, day: 1),
  base_date: 7.years.ago.change(month: 4, day: 1),
  part_time: false,
  classification: 0,
  user_id: normal_11.id
)

normal_pl_12 = PaidLeave.create( # nakayama
  joining_date: 7.years.ago.change(month: 4, day: 1),
  base_date: 7.years.ago.change(month: 4, day: 1),
  part_time: false,
  classification: 0,
  user_id: normal_12.id
)

Grant.create( # hamasaki
  granted_piece: 20,
  granted_day: Time.new(Date.today.year, 4, 1),
  user_id: normal_1.id,
  paid_leave_id: normal_pl_1.id
)

Grant.create( # taguti
  granted_piece: 20,
  granted_day: Time.new(Date.today.year, 4, 1),
  user_id: normal_2.id,
  paid_leave_id: normal_pl_2.id
)

Grant.create( # etou
  granted_piece: 20,
  granted_day: Time.new(Date.today.year, 4, 1),
  user_id: normal_3.id,
  paid_leave_id: normal_pl_3.id
)

Grant.create( # akimoto
  granted_piece: 20,
  granted_day: Time.new(Date.today.year, 4, 1),
  user_id: normal_4.id,
  paid_leave_id: normal_pl_4.id
)

Grant.create( # isihara
  granted_piece: 20,
  granted_day: Time.new(Date.today.year, 4, 1),
  user_id: normal_5.id,
  paid_leave_id: normal_pl_5.id
)

Grant.create( # matubara
  granted_piece: 20,
  granted_day: Time.new(Date.today.year, 4, 1),
  user_id: normal_6.id,
  paid_leave_id: normal_pl_6.id
)

Grant.create( # kawata
  granted_piece: 20,
  granted_day: Time.new(Date.today.year, 4, 1),
  user_id: normal_7.id,
  paid_leave_id: normal_pl_7.id
)

Grant.create( # tutiya
  granted_piece: 20,
  granted_day: Time.new(Date.today.year, 4, 1),
  user_id: normal_8.id,
  paid_leave_id: normal_pl_8.id
)

Grant.create( # hurutani
  granted_piece: 20,
  granted_day: Time.new(Date.today.year, 4, 1),
  user_id: normal_9.id,
  paid_leave_id: normal_pl_9.id
)

Grant.create( # simizu
  granted_piece: 11,
  granted_day: Time.new(Date.today.year, 4, 1),
  user_id: normal_10.id,
  paid_leave_id: normal_pl_10.id
)
