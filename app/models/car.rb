class Car < ApplicationRecord
  belongs_to :user

  validates :company_car, :private_car, length: { maximum: 30 }
end
