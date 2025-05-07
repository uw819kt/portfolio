class PaidLeavesController < ApplicationController
  before_action :set_paid_leave, only: %i[ show edit update ]

  def index
    @paid_leaves = PaidLeave.joins(:grant).includes(:approvals, :requests)
    @unapproved_request_count = Request.unapproved_count
  end

  def show
  end

  def new
    @user = User.find(params[:user_id])
    @paid_leave = @user.build_paid_leave
  end

  def create
    @user = User.find(params[:paid_leave][:user_id])
    @paid_leave = @user.build_paid_leave(paid_leave_params)

    if @paid_leave.save
      flash[:notice] = "有給休暇情報を登録しました。"
      redirect_to new_user_grant_path(user_id: @user.id)
    else
      @user.destroy
      flash[:alert] = "有給休暇情報を登録出来ませんでした。最初からやり直してください。"
      redirect_to new_user_path
    end
  end

  def edit
  end

  def update
    if @paid_leave.update(paid_leave_params)
      flash[:notice] = "有給休暇基礎情報を更新しました。"
      redirect_to user_path
    else
      flash[:alert] = "有給休暇基礎情報を更新出来ませんでした。"
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
