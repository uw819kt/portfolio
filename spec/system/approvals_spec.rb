require 'rails_helper'
# bundle exec rspec spec/system/approvals_spec.rb

RSpec.describe '有給承認機能', type: :system do
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

  describe '有給承認機能（new）' do
    context 'ログイン後有給承認ページにアクセスした場合' do
      it '新しい承認フォームが表示される' do
        login(user)
        visit requests_path(paid_leave)
        click_link "承認する", match: :first

        expect(page).to have_content('有給取得申請（承認）')
        expect(page).to have_field('approval[request_date]')
        expect(page).to have_field('approval[acquisition_date]')
        expect(page).to have_field('approval[paid_remarks]')
      end
    end
  end

  describe '有給承認機能（create）' do
    context 'ログイン後有給承認に成功した場合' do
      it '申請ページにリダイレクトされる' do
        login(user)
        visit requests_path(paid_leave)
        click_link "承認する", match: :first

        fill_in 'approval[request_date]', with: Date.today.to_s
        fill_in 'approval[acquisition_date]', with: (Date.today + 10).to_s
        fill_in 'approval[paid_remarks]', with: ''
        click_button '登録する'

        expect(page).to have_content('有給休暇申請を承認しました。')
        expect(current_path).to eq(request_path(paid_leave))
      end
    end

    context 'ログイン後有給承認に失敗した場合' do
      it 'フォームを再度レンダリングする' do
        login(user)
        visit requests_path(paid_leave)
        click_link "承認する", match: :first

        fill_in 'approval[request_date]', with: ''
        click_button '登録する'

        expect(current_path).to eq(request_path(paid_leave))
      end
    end
  end

  describe '承認済み詳細表示機能（show）' do
    context 'ログイン後有給承認済み詳細ページにアクセスした場合' do
      it '詳細画面が表示される' do
        login(user)
        approval = create(:approval, paid_leave: paid_leave)
        click_link "承認済", match: :first

        expect(page).to have_content('有給休暇取得状況詳細（承認済')
        expect(page).to have_content(approval.request_date.strftime('%Y年%m月%d日'))
      end

      it '承認が存在しない場合はリダイレクトされる' do
        login(user)
        click_link "承認済", match: :first

        expect(page).to have_content('現在承認済の有給休暇申請はありません。')
        expect(current_path).to eq(root_path)
      end
    end
  end

  describe '有給承認編集機能（edit）' do
    context 'ログイン後有給承認済詳細ページの編集リンクを押した場合' do
      it '承認編集フォームが表示される' do
        login(user)
        approval = create(:approval, user: user, paid_leave: paid_leave, request: request)

        click_link "承認済", match: :first
        click_link "編集する", match: :first

        expect(page).to have_content('有給取得申請編集')
        expect(page).to have_content('有給適用')
      end
    end
  end

  describe '有給承認編集機能（update）' do
    context 'ログイン後有給承認の編集に成功した場合' do
      it '承認を更新、承認済みページにリダイレクトされる' do
        # login(user)
        # approval = create(:approval, user: user, paid_leave: paid_leave)

        # visit paid_leave_approval_path(approval.paid_leave, 0)
        # visit edit_paid_leave_approval_path(approval.paid_leave, approval)

        # fill_in 'approval[request_date]', with: (Date.today + 7).to_s
        # click_button '更新'

        # expect(page).to have_content('有給休暇承認情報を更新しました。')
        # expect(current_path).to eq(paid_leave_approval_path(approval.paid_leave, approval))
      end
    end

    context 'ログイン後有給承認に失敗した場合' do
      it 'フォームを再度レンダリングする' do
        # login(user)
        # approval = create(:approval, user: user, paid_leave: paid_leave, request: request)

        # click_link "承認済", match: :first
        # click_link "編集する", match: :first

        # fill_in 'approval[request_date]', with: ''
        # click_button '更新する'

        # expect(current_path).to eq(edit_paid_leave_approval_path(paid_leave, approval))
      end
    end
  end
end
