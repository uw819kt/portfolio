class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update ]

  def index
    @users = User.includes(:car, :paid_leave).all
    @users = @users.order("paid_leaves.joining_date ASC")
    @cars = Car.all
    @paid_leaves = PaidLeave.all
  end

  def show
    @paid_leave = @user.paid_leave
    @car = @user.car
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "基本情報情報を更新しました。"
      redirect_to user_path
    else
      flash[:alert] = "基本情報情報を更新出来ませんでした。"
      render :edit, status: :unprocessable_entity
    end
  end

  def delete
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :department, :admin, :password, :password_confirmation)
  end
end
