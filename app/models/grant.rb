class Grant < ApplicationRecord
  belongs_to :paid_leave
  belongs_to :user

  validates :granted_piece, :granted_day, presence: true
  validates :paid_leave_id, presence: true, on: :update
end
