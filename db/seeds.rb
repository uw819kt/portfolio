# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

admin = User.create!( #arima
  name: "admin",
  email: "admin@example.com",
  department: 0,
  password: "password",
  password_confirmation: "password",
  admin: true
)

normal_1 = User.create!( #hamsaki
  name: "normal_1",
  email: "normal_1@example.com",
  department: 0,
  password: "",
  password_confirmation: "",
  admin: false
)

normal_2 = User.create!( #taguti
  name: "normal_2",
  email: "normal_2@example.com",
  department: 1,
  password: "",
  password_confirmation: "",
  admin: false
)

normal_3 = User.create!( #etou
  name: "normal_3",
  email: "normal_3@example.com",
  department: 1,
  password: "",
  password_confirmation: "",
  admin: false
)

normal_4 = User.create!( #akimoto
  name: "normal_4",
  email: "normal_4@example.com",
  department: 2,
  password: "",
  password_confirmation: "",
  admin: false
)

normal_5 = User.create!( #isihara
  name: "normal_5",
  email: "normal_5@example.com",
  department: 3,
  password: "",
  password_confirmation: "",
  admin: false
)

normal_6 = User.create!( #matubara
  name: "normal_6",
  email: "normal_6@example.com",
  department: 1,
  password: "",
  password_confirmation: "",
  admin: false
)

normal_7 = User.create!( #kawata
  name: "normal_7",
  email: "normal_7@example.com",
  department: 3,
  password: "",
  password_confirmation: "",
  admin: false
)

normal_8 = User.create!( #tutiya
  name: "normal_8",
  email: "normal_8@example.com",
  department: 3,
  password: "",
  password_confirmation: "",
  admin: false
)

normal_9 = User.create!( #hurutani
  name: "normal_9",
  email: "normal_9@example.com",
  department: 4,
  password: "",
  password_confirmation: "",
  admin: false
)

normal_10 = User.create!( #simizu
  name: "normal_10",
  email: "normal_9@example.com",
  department: 4,
  password: "",
  password_confirmation: "",
  admin: false
)

normal_11 = User.create!( #asano
  name: "normal_11",
  email: "normal_11@example.com",
  department: 5,
  password: "",
  password_confirmation: "",
  admin: false
)

normal_12 = User.create!( #nakayama
  name: "normal_12",
  email: "normal_12@example.com",
  department: 5,
  password: "",
  password_confirmation: "",
  admin: false
)

admin_car = Car.create( #arima
  company_car: "下関430た5533",
  private_car: "",
  user_id: admin_user.id
)

normal_car_1 = Car.create( #hamasaki
  company_car: "",
  private_car: "下関430つ5533",
  user_id: normal_user.id
)

normal_car_2 = Car.create( #taguti
  company_car: "",
  private_car: "下関430と5533",
  user_id: normal_user.id
)

normal_car_3 = Car.create( #etou
  company_car: "",
  private_car: "下関430て5533",
  user_id: normal_user.id
)

normal_car_4 = Car.create( #akimoto
  company_car: "",
  private_car: "",
  user_id: normal_user.id
)

normal_car_5 = Car.create( #isihara
  company_car: "",
  private_car: "",
  user_id: normal_user.id
)

normal_car_6 = Car.create( #matubara
  company_car: "",
  private_car: "下関430な5533",
  user_id: normal_user.id
)

normal_car_7 = Car.create( #kawata
  company_car: "",
  private_car: "",
  user_id: normal_user.id
)

normal_car_8 = Car.create( #tutiya
  company_car: "",
  private_car: "",
  user_id: normal_user.id
)

normal_car_7 = Car.create( #hurutani
  company_car: "",
  private_car: "",
  user_id: normal_user.id
)

normal_car_7 = Car.create( #shimizu
  company_car: "",
  private_car: "",
  user_id: normal_user.id
)

normal_car_7 = Car.create( #asano
  company_car: "下関483あ5533",
  private_car: "",
  user_id: normal_user.id
)

normal_car_7 = Car.create( #nakayama
  company_car: "",
  private_car: "",
  user_id: normal_user.id
)
