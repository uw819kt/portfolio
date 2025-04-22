class DriveAfLog < ApplicationRecord
  belongs_to :car
  belongs_to :user

  validates :check_time, :confirmation, :result, :condition, presence: true
  validates :detector_used, inclusion: { in: [true, false] }
  validates :log_remarks, length: { maximum: 30 }

  validate :check_duplicate_log_for_today

  enum :confirmation, {phone: 0, meeting: 1, others1: 2}
  enum :condition, {good: 0, bad: 1, others2: 2}

  private

  def check_duplicate_log_for_today
    return if check_time.blank? || user_id.blank?
    existing_log = DriveAfLog.where(user_id: user_id)
                             .where(check_time: check_time.beginning_of_day..check_time.end_of_day)
                             .where.not(id: id)

    if existing_log.exists?
      errors.add(:base, "本日はすでに運転記録（後）が登録されています")
    end
  end
end
