require "rails_helper"
# bundle exec rspec spec/mailers/user_mailer_spec.rb

RSpec.describe UserMailer, type: :mailer do
  describe "magic_linkメールのテスト" do
    let(:user) { create(:user) }
    let(:token) { Devise.friendly_token }

    subject(:mail) { described_class.magic_link(user, token) }

    context "登録したメールアドレスを送信した場合" do
      it "件名が表示される" do
      expect(mail.subject).to eq("ログイン用リンクのご案内")
    end

    it "正しいユーザーに送信する" do
      expect(mail.to).to eq([ user.email ])
    end

    it "本文にトークンが含まれる" do
      expect(mail.body.encoded).to include(token)
    end
    end
  end
end
