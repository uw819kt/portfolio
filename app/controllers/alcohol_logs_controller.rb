class AlcoholLogsController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:q]&.dig(:check_time_eq).present?
      date = Date.parse(params[:q][:check_time_eq])
    else
      date = Date.current
    end

    # 全ユーザー取得
    @users = User.includes(:drive_be_logs, :drive_af_logs)

    # 指定日のログを事前に検索しておく
    @be_logs = DriveBeLog.includes(:car).where(check_time: date.all_day).index_by(&:user_id)
    @af_logs = DriveAfLog.where(check_time: date.all_day).index_by(&:user_id)

    # Ransack用に @q だけ使う（検索フォーム用）
    @q = DriveBeLog.ransack(params[:q])
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
