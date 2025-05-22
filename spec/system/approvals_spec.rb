require 'rails_helper'
# bundle exec rspec spec/system/approvals_spec.rb

RSpec.describe '有給申請承認機能', type: :system do
  let!(:user) { create(:user) }
  let!(:paid_leave) { create(:paid_leave, user: user) }
  let!(:grant) { create(:grant, user: user, paid_leave: paid_leave) }
  let!(:request) { create(:request, user: user, paid_leave: paid_leave) }

  def login(user)
    visit new_user_session_path
    fill_in "メールアドレス", with: user.email
    click_button "ログイン"
    email = ActionMailer::Base.deliveries.last
    magic_link = email.body.to_s.match(/href="([^"]*)"/)[1]
    visit CGI.unescapeHTML(magic_link)
  end

  describe '有給承認機能（new, create）' do
    it '承認フォームが表示される' do
      login(user)

      visit new_request_path
      expect(page).to have_content('有給取得申請入力フォーム')
      expect(page).to have_content('申請日時')
    end

    it '承認登録が成功する' do
      login(user)

      visit new_request_path

      fill_in 'request_request_date', with: Date.today
      fill_in 'request_acquisition_date', with: Date.today + 5.days
      fill_in 'request_paid_remarks', with: '私用のため'

      click_button '登録する'

      expect(page).to have_content('申請を送信しました。')
      expect(current_path).to eq root_path
    end

    it '承認登録が失敗する（未入力など）' do
      login(user)
      visit new_request_path

      click_button '登録'

      expect(page).to have_content('有給取得申請入力フォーム')
    end
  end

  describe '承認済み詳細表示機能（show）' do
    context '承認がある場合' do
      let!(:approval) { create(:approval, paid_leave: paid_leave, request: request) }

      it '承認情報が表示される' do
        login(user)

        click_link "承認済", match: :first
        expect(page).to have_content('有給休暇取得状況詳細（承認済）')
        expect(page).to have_content(user.name)
      end
    end

    context '承認がない場合' do
      it 'リダイレクトされてメッセージが表示される' do
        login(user)

        visit paid_leave_approval_path(paid_leave, id: 999)
        expect(current_path).to eq root_path
        expect(page).to have_content('現在承認済の有給休暇申請はありません。')
      end
    end
  end

  describe '承認編集・更新機能（edit, update）' do
    let!(:approval) { create(:approval, paid_leave: paid_leave, request: request, paid_remarks: "旧メモ") }

    it '承認編集フォームが表示される' do
      login(user)

      click_link "承認済", match: :first
      click_link "編集する", match: :first

      expect(page).to have_content('有給取得申請編集')
      expect(page).to have_content('有給適用')
    end

    it '承認情報を更新できる' do
      login(user)

      visit edit_paid_leave_approval_path(paid_leave, approval)
      fill_in 'approval_paid_remarks', with: '更新済メモ'
      click_button '更新'

      expect(page).to have_content('有給休暇承認情報を更新しました。')
      expect(page).to have_content('更新済メモ')
    end

    it '更新に失敗した場合、エラーメッセージが表示される' do
      login(user)

      allow_any_instance_of(Approval).to receive(:update).and_return(false) # モデルのバリデーションが厳しい場合もここで代替可能
      visit edit_paid_leave_approval_path(paid_leave, approval)
      fill_in 'approval_paid_remarks', with: ''
      click_button '更新'

      expect(page).to have_content('有給休暇承認情報を更新出来ませんでした。')
    end
  end
end
