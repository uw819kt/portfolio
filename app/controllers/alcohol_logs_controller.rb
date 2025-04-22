class AlcoholLogsController < ApplicationController
  def index
    @drive_be_logs = DriveBeLog.order(user_id: :desc)
    @drive_af_logs = DriveAfLog.order(user_id: :desc)
  end

  def show
  end
end
