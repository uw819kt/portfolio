require 'rails_helper'
# bundle exec rspec spec/system/cars_spec.rb

RSpec.describe '車両記録機能', type: :system do
  let!(:user) { create(:user) }

  def login(user)
    visit new_user_session_path
    fill_in "メールアドレス", with: user.email
    click_button "ログイン"
    email = ActionMailer::Base.deliveries.last
    magic_link = email.body.to_s.match(/href="([^"]*)"/)[1]
    visit CGI.unescapeHTML(magic_link)
  end

  describe '車両番号登録・更新機能' do
    context 'ログイン後社員情報登録ページの入力フォームより' do
      it '正常に登録できる' do
        login(user)
        visit new_user_car_path(user)

        fill_in 'car_private_car', with: '下関100あ1111'
        fill_in 'car_company_car', with: ''
        click_button '登録'

        expect(page).to have_content('車両番号を登録しました。')
        expect(current_path).to eq(new_user_paid_leave_path(user_id: user.id))
      end

      it '更新に失敗するとレンダリングされる' do
        login(user)

        visit user_path(user)

        fill_in 'car_private_car', with: '2356'
        fill_in 'car_company_car', with: ''
        click_button '更新'

        expect(page).to have_content('車両番号を更新出来ませんでした。')
      end
    end
  end
end
