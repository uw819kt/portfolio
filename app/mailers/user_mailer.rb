class UserMailer < Devise::Mailer
  helper :application
  default template_path: "devise/mailer"

  def magic_link(record, token, opts = {})
    opts[:subject] = "ログイン用リンクのご案内"
    super
  end
end
