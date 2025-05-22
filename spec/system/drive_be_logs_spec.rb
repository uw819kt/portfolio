require 'rails_helper'
# bundle exec rspec spec/system/drive_be_logs_spec.rb

RSpec.describe '運転前記録機能', type: :system do
  let!(:user) { create(:user) }
  let!(:car) { create(:car, user: user) }

  def login(user)
    visit new_user_session_path
    fill_in "メールアドレス", with: user.email
    click_button "ログイン"
    email = ActionMailer::Base.deliveries.last
    magic_link = email.body.to_s.match(/href="([^"]*)"/)[1]
    visit CGI.unescapeHTML(magic_link)
  end

  describe '運転前の記録登録機能（new, create）' do
    context 'ログイン後運転前の記録登録ページの入力フォームより' do
      it '正常に登録できる' do
        login(user)
        visit new_drive_be_log_path

        select "manager", from: "drive_be_log_user_id"
        select "下関111あ1111", from: "drive_be_log_car_id"

        select "電話", from: "drive_be_log_confirmation"
        check "drive_be_log_detector_used"

        fill_in "drive_be_log_result", with: "0.00"
        select "良", from: "drive_be_log_condition"
        fill_in "drive_be_log_log_remarks", with: "問題なし"
        click_button '登録'

        expect(page).to have_content("運転前の記録を登録しました")
      end

      it '必須項目がないと失敗し、フォームが再表示される' do
        login(user)
        visit new_drive_be_log_path

        select "manager", from: "drive_be_log_user_id"
        select "下関111あ1111", from: "drive_be_log_car_id"

        select "電話", from: "drive_be_log_confirmation"
        check "drive_be_log_detector_used"

        fill_in "drive_be_log_result", with: ""
        select "良", from: "drive_be_log_condition"
        fill_in "drive_be_log_log_remarks", with: "問題なし"
        click_button '登録'

        expect(page).to have_content('酒気帯び記録入力フォーム（運転前）')
      end
    end
  end

  describe "運転前の記録編集（edit, update）" do
    let!(:log) { create(:drive_be_log, user: user, car: car, result: "0.01mg/L") }

    context 'ログイン後運転前の記録登録ページの入力フォームより' do
      it "正常に更新される" do
        login(user)
        visit alcohol_logs_path
        visit edit_drive_be_log_path(log)

        fill_in "drive_be_log_result", with: "0.00"
        click_button "更新"

        expect(page).to have_content("運転前の記録を更新しました")
        expect(current_path).to eq(alcohol_log_path(user))
      end

      it "更新に失敗するとフォームが再表示される" do
        login(user)
        visit alcohol_logs_path
        visit edit_drive_be_log_path(log)

        fill_in "drive_be_log_result", with: ""
        click_button "更新"

        expect(page).to have_content("測定結果を入力してください")
        expect(page).to have_current_path(drive_be_log_path(log))
      end
    end
  end
end
