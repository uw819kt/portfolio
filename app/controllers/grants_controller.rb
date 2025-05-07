class GrantsController < ApplicationController
  before_action :set_grant, only: %i[ new create edit update ]

  def new
    @user = User.find(params[:user_id])
    @paid_leave = @user.paid_leave
    @grant = @user.build_grant(paid_leave_id: @paid_leave.id)

    # 有給付与日数をUserモデルのメソッドで計算
    @granted_days =  @user.calculated_granted_days(@user.paid_leave)
  end

  def create
    @user = User.find(params[:user_id])
    @paid_leave = @user.paid_leave
    @grant = @user.build_grant(grant_params.merge(paid_leave_id: @paid_leave.id))

    # 有給付与日数をUserモデルのメソッドで計算
    @grant.granted_piece = @user.calculated_granted_days(@paid_leave)

    if @grant.save
      flash[:notice] = "有給休暇付与情報を登録しました。"
      redirect_to user_path(@user)
    else
      @user.destroy if @user.persisted? == false
      flash.now[:alert] = "有給休暇付与情報の登録に失敗しました。最初からやり直してください。"
      redirect_to new_user_path
    end
  end

  def edit
  end

  def update
    if @grant.update(grant_params)
      flash[:notice] = "有給休暇付与情報を更新しました。"
      redirect_to user_path(@user)
    else
      flash[:alert] = "有給休暇付与情報を更新出来ませんでした。"
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_grant
    @user = User.find(params[:user_id])
    @paid_leave = @user.paid_leave
    @grant = Grant.find_by(user_id: params[:user_id])
  end

  def grant_params
    params.require(:grant).permit(:granted_piece, :granted_day, :user_id, :paid_leave_id)
  end
end
