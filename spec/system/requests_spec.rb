require 'rails_helper'
# bundle exec rspec spec/system/requests_spec.rb

RSpec.describe '有給申請機能', type: :system do
  let!(:user) { create(:user) }
  let!(:paid_leave) { create(:paid_leave, user: user) }
  let!(:grant) { create(:grant, user: user, paid_leave: paid_leave) }

  def login(user)
    visit new_user_session_path
    fill_in "メールアドレス", with: user.email
    click_button "ログイン"
    email = ActionMailer::Base.deliveries.last
    magic_link = email.body.to_s.match(/href="([^"]*)"/)[1]
    visit CGI.unescapeHTML(magic_link)
  end

  describe '有給申請機能（new, reate）' do
    it '正しく申請を送信できる' do
      login(user)
      visit new_request_path

      fill_in 'request_request_date', with: Date.today
      fill_in 'request_acquisition_date', with: Date.today + 5.days
      fill_in 'request_paid_remarks', with: '私用のため'

      click_button '登録'

      expect(page).to have_content("申請を送信しました。")
      expect(current_path).to eq(root_path)
    end

    it '必須項目が不足していると失敗し、フォームが再表示される' do
      login(user)
      visit new_request_path

      # 未入力
      click_button '登録'

      expect(page).to have_current_path(requests_path)
    end
  end

  describe '管理者側/未承認一覧表示機能（index）' do
    it '管理者が未承認一覧を確認できる' do
      login(user)
      create(:request, user: user, paid_leave: paid_leave)

      visit requests_path
      expect(page).to have_content(user.name)
      expect(page).to have_content("有給休暇未確認一覧")
    end
  end

  describe '有給未承認詳細表示機能（show）' do
    it '詳細ページで有給残数と申請数が確認できる' do
    login(user)
    create(:request, user: user, paid_leave: paid_leave)

    visit request_path(paid_leave)
    expect(page).to have_content(user.name)
    expect(page).to have_content("有給休暇取得状況詳細（申請中）")
    expect(page).to have_content("承認未")
    end
  end
end
