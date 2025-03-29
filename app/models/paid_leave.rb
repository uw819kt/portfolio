class PaidLeave < ApplicationRecord
  belongs_to :user
  belongs_to :grant, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :approvals, dependent: :destroy

  validates :joining_date, :base_date, :part_time, 
    :classification, presence: true
    
  enum :classification, {
    "4days_w": 0,
    "3days_w": 1,
    "2days_w": 2,
    "1days_w": 3,
    "others": 4
    }
end
