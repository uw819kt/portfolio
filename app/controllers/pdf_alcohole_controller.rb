class PdfAlcoholeController < ApplicationController
  before_action :authenticate_user!

  def index # PDF出力を行う処理
    respond_to do |format|
      format.html
      format.pdf do
        date =
          if params[:q]&.dig(:check_time_eq).present?
            Date.parse(params[:q][:check_time_eq])
          else
            Date.current
          end

        users = User.all.includes(:drive_be_logs, :drive_af_logs)
        be_logs = DriveBeLog.where(check_time: date.all_day).index_by(&:user_id)
        af_logs = DriveAfLog.where(check_time: date.all_day).index_by(&:user_id)
        formatted_date = date.strftime("%Y年%m月%d日")

        pdf_output = PdfAlcohole.new(users, be_logs, af_logs, formatted_date).render
        issue_number = Time.current.strftime("%Y%m%d%H%M%S")

        send_data pdf_output,
          filename: "alcohole_log_#{issue_number}.pdf",
          type: "application/pdf",
          disposition: "inline" # 外すとアクセス時に自動ダウンロードされるようになる
      end
    end
  end
end
