class DriveBeLog < ApplicationRecord
  belongs_to :car
  belongs_to :user

  validates :check_time, :confirmation, :result, :condition, presence: true
  validates :detector_used, inclusion: { in: [true, false] }
  validates :log_remarks, length: { maximum: 30 }

  enum :confirmation, {phone: 0, meeting: 1, others1: 2}
  enum :condition, {good: 0, bad: 1, others2: 2}
end
