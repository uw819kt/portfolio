class User < ApplicationRecord
  has_one :paid_leave, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_one :grant, dependent: :destroy
  has_many :approvals, dependent: :destroy
  has_one :car, dependent: :destroy
  has_many :drive_be_logs, dependent: :destroy
  has_many :drive_af_logs, dependent: :destroy

  validates :name, :department, :email, presence: true
  validates :name, :email, length: { maximum: 255 }

  enum :department, {
    sales: 0,
    air_conditioning: 1,
    manufacturing: 2,
    design: 3,
    management: 4,
    others: 5
    }
end
