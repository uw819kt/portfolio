class PaidLeavesController < ApplicationController
  before_action :set_paid_leave, only: %i[ show ]

  def index
    @paid_leaves = PaidLeave.all
  end

  def show
    @paid_leaves = PaidLeave.all
  end

  private
  def set_paid_leave
    @paid_leave = PaidLeave.find(params[:id])
  end

  def paid_leave_params
    params.require(:paid_leave).permit(:joining_date, :base_date, :part_time, :classification, :user_id)
  end
end
