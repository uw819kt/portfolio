require 'rails_helper'
# bundle exec rspec spec/system/users_spec.rb

RSpec.describe '社員情報管理機能', type: :system do
  let!(:user) { create(:user) }

  def login(user)
    visit new_user_session_path
    fill_in "メールアドレス", with: user.email
    click_button "ログイン"
    email = ActionMailer::Base.deliveries.last
    magic_link = email.body.to_s.match(/href="([^"]*)"/)[1]
    visit CGI.unescapeHTML(magic_link)
  end

  describe '管理者による社員管理機能' do
    context '社員一覧表示機能（index）' do
      it '社員一覧が表示される' do
      login(user)

      visit users_path
      expect(page).to have_content("社員情報一覧")
      expect(page).to have_content(user.name)
      end
    end

    context '社員新規登録機能（new, reate）' do
      it '新規社員登録できる' do
        login(user)

        visit new_user_path
        fill_in 'user_name', with: 'normal_1'
        fill_in 'user_email', with: "user#{SecureRandom.hex(4)}@example.com"
        select '営業部', from: 'user_department'
        click_button '登録'

        expect(page).to have_content("基本情報を登録しました。")
        expect(current_path).to match(%r{/users/\d+/cars/new})
      end
    end

    context '社員詳細表示機能（show）' do
      it '社員詳細ページが表示される' do
        login(user)

        visit user_path(user)
        expect(page).to have_content(user.name)
        expect(page).to have_content(user.email)
      end
    end

    context '社員情報編集機能（edit, update）' do
      it '社員情報を編集できる' do
        login(user)

        visit edit_user_path(user)
        fill_in 'user_name', with: '山田花子'
        click_button '更新'

        expect(page).to have_content("基本情報を更新しました。")
        expect(page).to have_content('山田花子')
      end
    end

    context '社員情報削除機能（destroy）' do
      let!(:user_2) { create(:user_2) }

      it '社員を削除できる' do
        login(user)

        visit users_path(user)

        user_2 = User.find_by(name: 'normal_1')
        find("a[href='/admins/users/#{user_2.id}']", text: '削除する').click
        # accept_confirm { click_link '削除' }

        expect(page).to have_content("社員情報の削除が完了しました")
        expect(current_path).to eq(users_path)
        expect(page).not_to have_content(user_2.name)
      end
    end
  end

  describe '非管理者によるアクセス制限' do
    let!(:normal_user) { create(:user, is_admin: false) }

    it '一覧ページにアクセスできずリダイレクトされる' do
      login(normal_user)
      visit users_path

      expect(current_path).to eq(root_path)
      expect(page).to have_content("アクセス権限がありません。")
    end
  end
end
