class Approval < ApplicationRecord
  belongs_to :paid_leave
  belongs_to :user

  validates :request_date, :acquisition_date, presence: true
  validates :paid_remarks, length: { maximum: 255 }
  validates :paid_confirm, inclusion: { in: [ true, false ] }
  validates :paid_applicable, inclusion: { in: [ true, false ] }
end
