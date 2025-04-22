class Car < ApplicationRecord
  belongs_to :user

  validates :company_car, :private_car, length: { maximum: 30 }

  def car_number
    "#{company_car} #{private_car} "
  end
end
