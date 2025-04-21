class RequestsController < ApplicationController
  def new
    @request = Request.new
  end

  def create
    @request = Request.new(request_params)

    user_id = params.dig(:request, :user_id)
    user = User.find_by(id: user_id)

    if user && user.paid_leave
      @request.paid_leave_id = user.paid_leave.id
    else
      flash[:alert] = "申請情報を入力してください。"
      return render :new, status: :unprocessable_entity
    end
  
    if @request.save
      redirect_to root_path, notice: "申請を送信しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def request_params
    params.require(:request).permit(:user_id, :request_date, :acquisition_date, :paid_remarks)
  end
end
