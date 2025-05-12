class ApprovalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_paid_leave, only: %i[ new create show ]
  before_action :set_approval, only: %i[ edit update ]

  def new
    @request = Request.find(params[:request_id])

    @approval = @paid_leave.approvals.build(
      user_id: @paid_leave.user_id,
      request_date: @request&.request_date,
      acquisition_date: @request&.acquisition_date,
      paid_remarks: @request&.paid_remarks,
      paid_confirm: true,
      request_id: @request.id
    )
  end

  def create
    @request = Request.find(approval_params[:request_id])

    approval_attributes = approval_params.merge(
      user_id: @paid_leave.user_id,
      request_date: @request&.request_date,
      acquisition_date: @request&.acquisition_date,
      paid_remarks: @request&.paid_remarks,
      paid_confirm: true,
      request_id: @request.id
    )

    @approval = @paid_leave.approvals.build(approval_attributes)

    if @approval.save
      redirect_to request_path(@paid_leave), notice: "有給休暇申請を承認しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = @paid_leave.user
    @approval = @paid_leave.approvals
    @grant = @paid_leave.grant

    @approval_count = Approval.where(paid_leave_id:  @paid_leave.id, paid_applicable: true).count
    @achievements = (@grant.granted_piece) - (@approval_count)

    if @approval
      render :show
    else
      flash[:notice] = "現在承認済の有給休暇申請はありません。"
      redirect_to root_path
    end
  end

  def edit
    @paid_leave = PaidLeave.find(params[:id])
    @approval = Approval.find(params[:id])
  end

  def update
    @approval = Approval.find(params[:id])

    if @approval.update(approval_params)
      flash[:notice] = "有給休暇承認情報を更新しました。"
      redirect_to request_path(@approval.paid_leave_id)
    else
      flash[:alert] = "有給休暇承認情報を更新出来ませんでした。"
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def set_paid_leave
    @paid_leave = PaidLeave.find(params[:paid_leave_id])
  end

  def set_approval
    @approval = Approval.find(params[:id])
  end

  def approval_params
    params.require(:approval).permit(:request_date, :acquisition_date, :paid_remarks, :paid_applicable, :request_id)
  end
end
