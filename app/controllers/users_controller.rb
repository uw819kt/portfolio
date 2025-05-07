class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  def index
    @users = User.includes(:car, :paid_leave).order("users.id ASC")
    @cars = Car.all
    @paid_leaves = PaidLeave.all
  end

  def show
    @paid_leave = @user.paid_leave
    @car = @user.car || @user.build_car
    @grant = Grant.find_by(user_id: @user.id, paid_leave_id: @user.paid_leave&.id)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
  if @user.save
    Passwordless::Session.create!(
      authenticatable: @user,
      user_agent: request.user_agent,
      remote_addr: request.remote_ip
    ).tap do |session|
      Passwordless::Mailer.magic_link(session).deliver_later
    end

    flash[:notice] = "登録完了!ログインリンクをメールで送信しました。"
    redirect_to root_path
  else
    flash[:alert] = "登録出来ませんでした"
    render :new, status: :unprocessable_entity
  end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "基本情報を更新しました。"
      redirect_to user_path
    else
      flash[:alert] = "基本情報を更新出来ませんでした。"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @user.destroy
      flash[:notice] = '社員情報の削除が完了しました'
      redirect_to users_path, status: :see_other
    else
      flash[:danger] = @user.errors.full_messages.to_sentence
      redirect_to user_path(@user), status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :department)
  end
end
