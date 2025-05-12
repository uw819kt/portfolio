class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  protected

  def after_magic_link_sent_path_for(resource)
    flash[:notice] = "ログイン用リンクをメールアドレス宛に送信しました。メールをご確認ください。"
    new_user_session_path
  end

  def after_sign_out_path_for(resource_or_scope)# ログイン画面のパス
    new_user_session_path
  end
end
