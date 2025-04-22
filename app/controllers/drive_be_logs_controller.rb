class DriveBeLogsController < ApplicationController
  def new
    @drive_be_log = DriveBeLog.new
  end

  def create
    @drive_be_log = DriveBeLog.new(drive_be_log_params)
    @drive_be_log.check_time = Time.zone.now

    if @drive_be_log.save
      redirect_to alcohol_logs_path, notice: "運転前の記録を登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def drive_be_log_params
    params.require(:drive_be_log).permit(:check_time, :confirmation, :detector_used, :result, :condition, :log_remarks, :user_id, :car_id)
  end
end
