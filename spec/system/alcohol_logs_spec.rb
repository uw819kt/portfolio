require 'rails_helper'
# bundle exec rspec spec/system/alcohol_logs_spec.rb

RSpec.describe '酒気帯び記録機能', type: :system do
  let!(:user) { create(:user) }
  let!(:be_log) { create(:drive_be_log, user: user, check_time: Time.zone.today.midday) }
  let!(:af_log) { create(:drive_af_log, user: user, check_time: Time.zone.today.midday) }

  def login(user)
    visit new_user_session_path
    fill_in "メールアドレス", with: user.email
    click_button "ログイン"
    email = ActionMailer::Base.deliveries.last
    magic_link = email.body.to_s.match(/href="([^"]*)"/)[1]
    visit CGI.unescapeHTML(magic_link)
  end

  describe '一覧表示機能（index）' do
    context 'ログイン後酒気帯び一覧ページにアクセスした場合' do
      it '一覧画面が表示される' do
        login(user)
        visit alcohol_logs_path

        expect(page).to have_content("酒気帯び確認記録表")
        expect(page).to have_content(user.name)
        expect(page).to have_content(be_log.check_time.strftime("%m/%d %H:%M"))
      end
    end
  end

  describe '詳細表示機能（show）' do
    context 'ログイン後酒気帯び一覧ページにアクセスした場合' do
      it '詳細画面が表示される' do
      end
    end
  end
end
