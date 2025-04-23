class CarsController < ApplicationController
  def update
    @car = Car.find(params[:id])
    if @car.update(car_params)
      flash[:notice] = "車両番号を更新しました。"
      redirect_to user_path
    else
      flash[:alert] = "車両番号を更新出来ませんでした。"
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def car_params
    params.require(:car).permit(:company_car, :private_car, :user_id)
  end
end
