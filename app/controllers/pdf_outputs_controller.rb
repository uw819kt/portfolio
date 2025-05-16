class PdfOutputsController < ApplicationController
  def index # PDF出力を行う処理
    respond_to do |format|
      format.html
      format.pdf do
        pdf_output = PdfOutput.new().render
        issue_number = Time.current.strftime("%Y%m%d%H%M%S")
        send_data pdf_output,
          filename: "alcohole_log_#{issue_number}.pdf",
          type: "application/pdf",
          disposition: "inline" # 外すとアクセス時に自動ダウンロードされるようになる
      end
    end
  end
end
