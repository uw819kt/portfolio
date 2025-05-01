class Request < ApplicationRecord
  belongs_to :paid_leave
  belongs_to :user
  has_one :approval

  validates :request_date, :acquisition_date, presence: true
  validates :paid_remarks, length: { maximum: 255 }

  scope :without_approval, -> { left_outer_joins(:approval).where(approvals: { id: nil }) }

  def approval_link # 編集/承認リンク表示を分けるメソッド
    if approval.present?
      Rails.application.routes.url_helpers.edit_paid_leave_approval_path(paid_leave_id, approval.id)
    else
      Rails.application.routes.url_helpers.new_paid_leave_approval_path(paid_leave_id)
    end
  end

  def self.unapproved_count # 未承認件数を集計
    without_approval.count
  end
end
