class PaidLeave < ApplicationRecord
  belongs_to :user
  # belongs_to :grant, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :approvals, dependent: :destroy

  validates :joining_date, :base_date, :part_time,
    :classification, presence: true

  enum :classification, {
    "full-time": 0,
    "4days_w": 1,
    "3days_w": 2,
    "2days_w": 3,
    "1days_w": 4,
    "others": 5
    }
end
