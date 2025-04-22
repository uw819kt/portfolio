class Request < ApplicationRecord
  belongs_to :paid_leave
  belongs_to :user
  has_one :approval

  validates :request_date, :acquisition_date, presence: true
  validates :paid_remarks, length: { maximum: 255 }
end
