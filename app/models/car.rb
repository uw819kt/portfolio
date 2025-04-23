class Car < ApplicationRecord
  belongs_to :user

  validates :company_car, :private_car, length: { maximum: 30 }

  VALID_CAR_NUMBER_REGEX = /\A[一-龥ぁ-ん]{1,4}\d{3}[ぁ-ん]\d{4}\z/
  validate :car_number_format

  def car_number
    "#{company_car} #{private_car} "
  end

  private

  def car_number_format
    number = private_car.presence || company_car
    return if number.blank? # どちらも空ならバリデーションスキップ

    unless number.match?(VALID_CAR_NUMBER_REGEX)
      errors.add(:base, "車両番号の形式が不正です（例: 下関500あ1234）")
    end
  end
end
