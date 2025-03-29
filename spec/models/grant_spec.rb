require 'rails_helper'
# bundle exec rspec spec/models/grant_spec.rb

RSpec.describe '有給付与情報登録機能', type: :model do
  let!(:user) { FactoryBot.create(:user) }
  let!(:paid_leave) { FactoryBot.create(:paid_leave) }
  describe 'バリデーションのテスト' do
    context '登録フォームの付与日数が空文字の場合' do
      it 'バリデーションに失敗する' do
        grant = Grant.create(granted_piece: "", granted_day: "2024-10-01", user: user, paid_leave: paid_leave)
        expect(grant).not_to be_valid
      end
    end

    context '登録フォームの付与日が空文字の場合' do
      it 'バリデーションに失敗する' do
        grant = Grant.create(granted_piece: 20, granted_day: "", user: user, paid_leave: paid_leave)
        expect(grant).not_to be_valid
      end
    end

    context '登録フォームの全てに値が入っている場合' do
      it '有給付与情報を登録できる' do
        grant = Grant.create(granted_piece: 20, granted_day: "2024-10-01", user: user, paid_leave: paid_leave)
        expect(grant).to be_valid
      end
    end
  end
end
