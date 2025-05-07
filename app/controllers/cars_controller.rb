class CarsController < ApplicationController
  before_action :set_car, only: %i[ update ]

  def new
    @user = User.find(params[:user_id])
    @car = @user.build_car
  end

  def create
    @user = User.find(params[:car][:user_id])
    @car = @user.build_car(car_params)

    if @car.save
      flash[:notice] = "車両番号を登録しました。"
      redirect_to new_user_paid_leave_path(user_id: @user.id)
    else
      @user.destroy
      flash[:alert] = "車両番号を登録出来ませんでした。最初からやり直してください。"
      redirect_to new_user_path
    end
  end

  def update
    @car = Car.find(params[:id])
    @user = @car.user

    if @car.update(car_params)
      flash[:notice] = "車両番号を更新しました。"
      redirect_to user_path(@user)
    else
      flash[:alert] = "車両番号を更新出来ませんでした。"
      render "users/show", status: :unprocessable_entity
    end
  end

  private
  def set_car
    @car = Car.find(params[:id])
  end

  def car_params
    params.require(:car).permit(:company_car, :private_car, :user_id)
  end
end
