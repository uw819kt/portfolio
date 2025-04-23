class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update ]

  def index
    @users = User.includes(:car, :paid_leave).order("users.id ASC")
    @cars = Car.all
    @paid_leaves = PaidLeave.all
  end

  def show
    @paid_leave = @user.paid_leave
    @car = @user.car
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "基本情報を登録しました。"
      redirect_to new_user_car_path(user_id: @user.id)
    else
      flash[:alert] = "基本情報情報を登録出来ませんでした"
      render :new, status: :unprocessable_entity
    end
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
    params.require(:user).permit(:name, :email, :department)
  end
end
