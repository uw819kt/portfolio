class User < ApplicationRecord
  has_one :paid_leave, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_one :grant, dependent: :destroy
  has_many :approvals, dependent: :destroy
  has_one :car, dependent: :destroy
  has_many :drive_be_logs, dependent: :destroy
  has_many :drive_af_logs, dependent: :destroy

  validates :name, :department, :email, presence: true
  validates :name, :email, length: { maximum: 255 }

  enum :department, {
    sales: 0,
    air_conditioning: 1,
    manufacturing: 2,
    design: 3,
    management: 4,
    others: 5
    }


  def calculated_granted_days(paid_leave) # 付与日数計算
    if paid_leave.part_time?
      part_time_plan(paid_leave.classification)
    else
      full_time_plan
    end
  end

  def years_of_service # 勤続年数
    reference = (paid_leave.base_date - paid_leave.joining_date).to_i/ 365.25
    years_of_service = reference.round(1)
  end
  
  def part_time_plan(classification) # 有給休暇付与予定日数
    years = self.years_of_service.to_f

    case classification
    when "4days_w" # 週4日＆30時間以下の場合
      return case years
      when 0.5...1.5 then 7
      when 1.5...2.5 then 8
      when 2.5...3.5 then 9
      when 3.5...4.5 then 10
      when 4.5...5.5 then 12
      when 5.5...6.5 then 13
      else 15
      end
    when "3days_w" # 週3日＆30時間以下の場合
      return case years
      when 0.5...1.5 then 5
      when 1.5...2.5 then 6
      when 2.5...3.5 then 6
      when 3.5...4.5 then 8
      when 4.5...5.5 then 9
      when 5.5...6.5 then 10
      else 11
      end
    when "2days_w" # 週2日＆30時間以下の場合
      return case years
      when 0.5...1.5 then 3
      when 1.5...2.5 then 4
      when 2.5...3.5 then 4
      when 3.5...4.5 then 5
      when 4.5...5.5 then 6
      when 5.5...6.5 then 6
      else 7
      end
    when "1days_w" # 週1日＆30時間以下の場合
      return case years
      when 0.5...1.5 then 1
      when 1.5...2.5 then 2
      when 2.5...4.5 then 2
      when 4.5...6.5 then 3
      else 3
      end
    else
      return 0
    end    
  end  

  def full_time_plan # 有給休暇付与予定日数
    years = self.years_of_service.to_f

    case years
    when 0.5...1.5 then 10
    when 1.5...2.5 then 11
    when 2.5...3.5 then 12
    when 3.5...4.5 then 14
    when 4.5...5.5 then 16
    when 5.5...6.5 then 18
    else years >= 6.5 ? 20 : 0
    end
  end
end
