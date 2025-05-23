class Users::GuestSessionsController < ApplicationController
  include Devise::Controllers::Helpers

  def guest_sign_in
    user = User.guest_general
    bypass_sign_in(user)
    redirect_to root_path, notice: "ゲスト（一般）ユーザーとしてログインしました。"
  end

  def guest_admin_sign_in
    user = User.guest_admin
    sign_in(:user, user)
    redirect_to root_path, notice: "ゲスト（管理者）ユーザーとしてログインしました。"
  end
end
