class AlcoholLogsController < ApplicationController
  def index
    @drive_be_logs = DriveBeLog.order(user_id: :desc)
    @drive_af_logs = DriveAfLog.order(user_id: :desc)
    # @drive_be_logs = DriveBeLog.where(check_time: Date.current.all_day).order(user_id: :desc)
    # @drive_af_logs = DriveAfLog.where(check_time: Date.current.all_day).order(user_id: :desc)
  end

  def show
    @user = User.find(params[:id])

    start_date = Time.zone.today.beginning_of_day - 29.days
    end_date = Time.zone.today.end_of_day

    @drive_be_log = @user.drive_be_logs
                        .where(check_time: start_date..end_date)
                        .order(check_time: :desc)

    @drive_af_log = @user.drive_af_logs
                        .where(check_time: start_date..end_date)
                        .order(check_time: :desc)
  end
end
