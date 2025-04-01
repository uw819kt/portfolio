require 'rails_helper'
# bundle exec rspec spec/models/approval_spec.rb

RSpec.describe '有給取得編集機能', type: :model do
  let!(:user) { FactoryBot.create(:user) }
  let!(:paid_leave) { FactoryBot.create(:paid_leave) }
  describe 'バリデーションのテスト' do
    context '編集フォームの申請日時が空文字の場合' do
      it 'バリデーションに失敗する' do
        approval = Approval.create(request_date: "", acquisition_date: "2024-10-13", paid_applicable: true, paid_remarks: "", user: user, paid_leave: paid_leave)
        expect(approval).not_to be_valid
      end
    end

    context '編集フォームの取得日が空文字の場合' do
      it 'バリデーションに失敗する' do
        approval = Approval.create(request_date: "2024-10-05", acquisition_date: "", paid_applicable: true, paid_remarks: "", user: user, paid_leave: paid_leave)
        expect(approval).not_to be_valid
      end
    end

    context '編集フォームの備考以外に値が入っている場合' do
      it '有給取得申請編集内容を登録できる' do
        approval = Approval.create(request_date: "2024-10-05", acquisition_date: "2024-10-13", paid_applicable: true, paid_remarks: "", user: user, paid_leave: paid_leave)
        expect(approval).to be_valid
      end
    end
  end
end
