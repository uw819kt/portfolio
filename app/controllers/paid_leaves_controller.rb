class PaidLeavesController < ApplicationController
  before_action :set_paid_leave, only: %i[ show edit update ]

  def index
    @paid_leaves = PaidLeave.includes(:user).all
  end

  def show
  end

  def new
    @user = User.find(params[:user_id])
    @paid_leave = @user.build_paid_leave
  end

  def create
    binding.irb
    @user = User.find(params[:paid_leave][:user_id])
    @paid_leave = @user.build_paid_leave(paid_leave_params)

    if @paid_leave.save
      flash[:notice] = "有給休暇情報を登録しました。"
      redirect_to users_path
    else
      flash[:alert] = "有給休暇情報を登録出来ませんでした。"
      render :new, status: :unprocessable_entity
    end
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
