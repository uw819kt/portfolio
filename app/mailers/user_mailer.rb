class UserMailer < Devise::Mailer
  def magic_link(record, token, opts = {})
    opts[:subject] = "ログイン用リンクのご案内"
    super
  end
end
