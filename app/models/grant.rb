class Grant < ApplicationRecord
  belongs_to :paid_leave
  belongs_to :user

  validates :granted_piece, :granted_day, presence: true
  validates :paid_leave_id, presence: true, on: :update
  validates :granted_piece, numericality: { less_than_or_equal_to: 99 }
end
