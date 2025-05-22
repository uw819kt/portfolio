require 'rails_helper'
# bundle exec rspec spec/system/paid_leaves_spec.rb

RSpec.describe '有給休暇基礎情報機能', type: :system do
  let!(:user) { create(:user) }

  def login(user)
    visit new_user_session_path
    fill_in "メールアドレス", with: user.email
    click_button "ログイン"
    email = ActionMailer::Base.deliveries.last
    magic_link = email.body.to_s.match(/href="([^"]*)"/)[1]
    visit CGI.unescapeHTML(magic_link)
  end

  describe '有給休暇基礎情報の登録機能（new, create）' do
    it "正常に登録できる" do
      login(user)
      visit users_path
      click_link "詳細", match: :first
      click_link "有給休暇基礎情報を新規登録", match: :first

      fill_in "paid_leave_joining_date", with: Date.today.to_s
      fill_in "paid_leave_base_date", with: Date.today.to_s
      select 'フルタイム', from: 'paid_leave_classification'
      click_button "登録"

      expect(page).to have_content("有給休暇情報を登録しました。")
    end
  end

  describe '有給休暇基礎情報の編集機能（edit, update）' do
    let!(:paid_leave) { create(:paid_leave, user: user) }

    it "正常に更新できる" do
      login(user)
      visit edit_paid_leave_path(paid_leave)

      fill_in "paid_leave_base_date", with: (Date.today + 10).to_s
      click_button "更新する"

      expect(page).to have_content("有給休暇情報を登録しました。")
    end

    it "更新に失敗するとエラーになる" do
      login(user)
      visit edit_paid_leave_path(paid_leave)

      fill_in "paid_leave_base_date", with: ""
      click_button "更新"

      expect(page).to have_content("有給休暇基礎情報を更新出来ませんでした。")
      expect(current_path).to eq(paid_leave_path(paid_leave))
    end
  end
end
