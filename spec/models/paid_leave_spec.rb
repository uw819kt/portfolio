require 'rails_helper'
# bundle exec rspec spec/models/paid_leave_spec.rb

RSpec.describe '有給情報登録機能', type: :model do
  let!(:user) { FactoryBot.create(:user) }
  describe 'バリデーションのテスト' do
    context '登録フォームの入社日が空文字の場合' do
      it 'バリデーションに失敗する' do
        paid_leave = PaidLeave.create(joining_date: "", base_date: "2024-04-01", part_time: false, classification: "", user: user)
        expect(paid_leave).not_to be_valid
      end
    end

    context '登録フォームの基準日が空文字の場合' do
      it 'バリデーションに失敗する' do
        paid_leave = PaidLeave.create(joining_date: "2003-04-01", base_date: "", part_time: false, classification: "", user: user)
        expect(paid_leave).not_to be_valid
      end
    end

    context '登録フォームのパートタイム（勤務形態）以外に値が入っている場合' do
      it '有給情報登録を登録できる' do
        paid_leave = PaidLeave.create(joining_date: "2003-04-01", base_date: "2024-04-01", part_time: false, classification: "", user: user)
        expect(paid_leave).to be_valid
      end
    end
  end
end
