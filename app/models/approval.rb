class Approval < ApplicationRecord
  belongs_to :paid_leave
  belongs_to :user

  validates :request_date, :acquisition_date,
    :paid_applicable, :paid_confirm, presence: true
  validates :paid_remarks, length: { maximum: 255 }
end
