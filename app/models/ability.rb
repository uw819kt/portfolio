# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    if user.admin?
      can :manage, :all # 管理者：すべて可能
    else
      can :read, [ AlcoholLog, Approval, PaidLeave ]   # 一般ユーザー：制限有
      can :create, [ DriveAfLog, DriveBeLog ]
      can [ :read, :create ], [ Request ]
    end
  end
end
