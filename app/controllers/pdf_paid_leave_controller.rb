class PdfPaidLeaveController < ApplicationController
  before_action :authenticate_user!

  def index
    respond_to do |format|
      @paid_leave = PaidLeave.find(params[:paid_leave_id])
      @user = @paid_leave.user
      @approval = @paid_leave.approvals
      @grant = @paid_leave.grant

      @approval_count = Approval.where(paid_leave_id:  @paid_leave.id, paid_applicable: true).count
      @achievements = (@grant.granted_piece) - (@approval_count)

      format.html
      format.pdf do
        date = Date.current

        pdf_output = PdfPaidLeave.new(@paid_leave, @user, @grant, @approval, @achievements, date).render
        issue_number = Time.current.strftime("%Y%m%d%H%M%S")

        send_data pdf_output,
          filename: "Paid_leave_log_#{issue_number}.pdf",
          type: "application/pdf",
          disposition: "inline" # 外すとアクセス時に自動ダウンロードされるようになる
      end
    end
  end
end
