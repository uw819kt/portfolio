require 'rails_helper'
# bundle exec rspec spec/models/request_spec.rb

RSpec.describe '有給取得申請機能', type: :model do
  let!(:user) { FactoryBot.create(:user) }
  let!(:paid_leave) { FactoryBot.create(:paid_leave) }
  describe 'バリデーションのテスト' do
    context '申請フォームの申請日時が空文字の場合' do
      it 'バリデーションに失敗する' do
        request = Request.create(request_date: "", acquisition_date: "2024-10-13", paid_remarks: "", user: user, paid_leave: paid_leave)
        expect(request).not_to be_valid
      end
    end

    context '申請フォームの取得日が空文字の場合' do
      it 'バリデーションに失敗する' do
        request = Request.create(request_date: "2024-10-05", acquisition_date: "", paid_remarks: "", user: user, paid_leave: paid_leave)
        expect(request).not_to be_valid
      end
    end

    context '申請フォームの備考以外に値が入っている場合' do
      it '有給取得申請内容を登録できる' do
        request = Request.create(request_date: "2024-10-05", acquisition_date: "2024-10-13", paid_remarks: "", user: user, paid_leave: paid_leave)
        expect(request).to be_valid
      end
    end
  end
end
