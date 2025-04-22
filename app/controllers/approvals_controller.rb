class ApprovalsController < ApplicationController

  def show
  end

  def edit
    @request = Request.find(params[:id])
    @approval = @request.build(approval_params)
  end

  def update
    @approval = JobApplication.find(params[:id])
    if @job_application.update(job_application_params)
      flash[:notice] = "ステータスを更新しました。"
      redirect_to company_job_applications_path
    else
      flash[:alert] = "ステータスを更新出来ませんでした。"
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def approval_params
    params.require(:approval).permit(:user_id, :request_date, :acquisition_date, :paid_remarks, :paid_applicable)
  end
end
