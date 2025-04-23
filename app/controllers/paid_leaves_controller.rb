class PaidLeavesController < ApplicationController
  before_action :set_paid_leave, only: %i[ show edit update ]

  def index
    @paid_leaves = PaidLeave.includes(:user).all
  end

  def show
  end

  def edit
  end

  def update
    if @paid_leave.update(paid_leave_params)
      flash[:notice] = "有給休暇関連情報を更新しました。"
      redirect_to user_path
    else
      flash[:alert] = "有給休暇関連情報を更新出来ませんでした。"
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def set_paid_leave
    @paid_leave = PaidLeave.find(params[:id])
  end

  def paid_leave_params
    params.require(:paid_leave).permit(:joining_date, :base_date, :part_time, :classification, :user_id)
  end
end
