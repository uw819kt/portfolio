require 'rails_helper'
# bundle exec rspec spec/system/grants_spec.rb

RSpec.describe '有給休暇付与情報記録機能', type: :system do
  let!(:user) { create(:user) }

  def login(user)
    visit new_user_session_path
    fill_in "メールアドレス", with: user.email
    click_button "ログイン"
    email = ActionMailer::Base.deliveries.last
    magic_link = email.body.to_s.match(/href="([^"]*)"/)[1]
    visit CGI.unescapeHTML(magic_link)
  end

  describe '有給付与情報登録（new, create）' do
    context '有給休暇基礎情報がある場合' do
      let!(:paid_leave) { create(:paid_leave, user: user) }

      it '正常に有給休暇付与情報が登録できる' do
        login(user)
        visit users_path
        click_link "詳細", match: :first
        click_link "有給休暇付与情報を新規登録", match: :first

        # 有給休暇付与情報
        fill_in 'grant_granted_piece', with: 20
        fill_in 'grant_granted_day', with: Date.today.to_s

        click_button '登録'

        expect(page).to have_content('有給休暇付与情報を登録しました。')
        expect(current_path).to eq(user_path(user))
      end

      it '更新に失敗するとレンダリングされる' do
        login(user)
        visit users_path
        click_link "詳細", match: :first
        click_link "有給休暇付与情報を新規登録", match: :first

        # 入力せず登録
        click_button '登録'

        expect(page).to have_content('有給休暇付与情報の登録に失敗しました。')
      end
    end

    context '有給休暇基礎情報がない場合' do
      it '有給休暇基礎情報がない旨のエラーメッセージが表示される' do
        user_without_paid_leave = create(:user)
        login(user_without_paid_leave)

        visit new_user_grant_path(user_id: user_without_paid_leave.id)

        expect(page).to have_content('有給休暇基礎情報が存在しません。先に登録してください。')
        expect(current_path).to eq(user_path(user_without_paid_leave))  # ユーザー情報ページにリダイレクトされる
      end
    end
  end

  describe '付与情報更新（edit, update）' do
    let!(:paid_leave) { create(:paid_leave, user: user) }
    let!(:grant) { create(:grant, user: user, paid_leave: paid_leave) }

    context '付与情報が存在する場合' do
      it '有給休暇付与情報が正常に更新できる' do
        login(user)

        visit edit_user_grant_path(user_id: user.id, id: grant.id)

        fill_in 'grant_granted_piece', with: 12
        fill_in 'grant_granted_day', with: (Date.today + 10).to_s

        click_button '更新'

        expect(page).to have_content('有給休暇付与情報を更新しました。')
        expect(current_path).to eq(user_path(user))
      end

      it '有給休暇付与情報の更新に失敗した場合、エラーメッセージが表示される' do
        login(user)

        visit edit_user_grant_path(user_id: user.id, id: grant.id)

        fill_in 'grant_granted_piece', with: ''  # 必須項目を空にする

        click_button '更新'

        expect(page).to have_content('有給休暇付与情報を更新出来ませんでした。')
        expect(current_path).to eq(user_grant_path(user, grant))
      end
    end
  end
end
