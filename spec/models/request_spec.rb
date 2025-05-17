require 'rails_helper'
# bundle exec rspec spec/models/request_spec.rb

RSpec.describe Request, type: :model do
  it { should belong_to(:paid_leave) }
  it { should belong_to(:user) }

  it { is_expected.to validate_presence_of :request_date }
  it { is_expected.to validate_presence_of :acquisition_date }
  it { is_expected.to validate_length_of(:paid_remarks).is_at_most(255) }

  describe 'リンク表示のテスト' do
    let!(:user) { create(:user) }
    let!(:paid_leave) { create(:paid_leave) }

    context '有給申請が承認されてない場合' do
      let!(:request) { create(:request, user: user, paid_leave: paid_leave) }

      it '承認リンクが表示される' do
        expect(request.approval_link).to eq(
          Rails.application.routes.url_helpers.new_paid_leave_approval_path(paid_leave.id)
        )
      end
    end

    context '有給申請が承認されている場合' do
      let!(:request_2) { create(:request_2, user: user, paid_leave: paid_leave) }
      let!(:approval) { create(:approval, request: request_2) }

      it '編集リンクが表示される' do
        expect(request_2.approval_link).to eq(
          Rails.application.routes.url_helpers.edit_paid_leave_approval_path(paid_leave.id, approval.id)
        )
      end
    end
  end

  describe '未承認件数の集計' do
    it '承認のないリクエストのみをカウントする' do
      create_list(:request, 3) # approval 無し
      create(:approval) # approval ありの request を 1 件生成

      expect(Request.unapproved_count).to eq(3)
    end
  end
end
