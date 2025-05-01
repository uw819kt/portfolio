class PaidLeave < ApplicationRecord
  belongs_to :user
  has_one :grant, dependent: :destroy
  has_one :scoped_grant, ->(pl) { where(user_id: pl.user_id) }, class_name: "Grant"
  has_many :requests, dependent: :destroy
  has_many :approvals, dependent: :destroy

  validates :joining_date, :base_date, :classification, presence: true
  validates :part_time, inclusion: { in: [ true, false ] }

  enum :classification, {
    "full-time": 0,
    "4days_w": 1,
    "3days_w": 2,
    "2days_w": 3,
    "1days_w": 4,
    "others": 5
    }

  def approved_approval # approvalがあるか検索
    approvals.where(paid_confirm: true)
  end

  def paid_achievements # 有給取得実績
    return nil unless  base_date

    one_year_later =  base_date + 1.year

    used_count = approvals
      .where(paid_applicable: true)
      .where(acquisition_date:  base_date...one_year_later)
      .count
  end

  def paid_totalling(month) # 有給取得月間集計
    return nil unless grant&.granted_day

    year = base_date.year

    start_date = Date.new(year, month, 1)
    end_date = start_date.end_of_month

    approvals
      .where(paid_applicable: true)
      .where(acquisition_date: start_date..end_date)
      .count
  end
end
