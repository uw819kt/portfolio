class UserMailer < Devise::Passwordless::Mailer
  helper :application
  default template_path: "devise/mailer"

  def magic_link(record, token, opts = {})
    opts[:subject] = "ログイン用リンクのご案内"
    opts[:body] = "ログインリンク: #{token}"
    super(record, token, opts)
  end
end
