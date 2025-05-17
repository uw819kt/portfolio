require 'rails_helper'
# bundle exec rspec spec/models/paid_leave_spec.rb

RSpec.describe PaidLeave, type: :model do
  it { should belong_to(:user) }
  it { should have_one(:grant).dependent(:destroy) }
  it { should have_many(:requests).dependent(:destroy) }
  it { should have_many(:approvals).dependent(:destroy) }

  it { is_expected.to validate_presence_of :joining_date }
  it { is_expected.to validate_presence_of :base_date }
  it { is_expected.to allow_value("true").for(:part_time) }
  it { is_expected.to allow_value("false").for(:part_time) }
  it { is_expected.not_to allow_value(nil).for(:part_time) }
  it { is_expected.to validate_presence_of :classification }

  describe 'approved_approvalのテスト' do
    context '有給申請の中に承認済みのデータがある場合' do
      it 'paid_confirmがtrueのデータが抽出される' do
        paid_leave = create(:paid_leave)
        create(:approval, paid_leave: paid_leave, paid_confirm: true)
        create(:approval, paid_leave: paid_leave, paid_confirm: false)

        result = paid_leave.approved_approval
        expect(result.count).to eq(1)
        expect(result.first.paid_confirm).to be true
      end
    end
  end

  describe 'paid_achievementsのテスト' do
    context 'base_dateがnilではない場合' do
      it 'base_dateから1年以内の有給取得実績を返す' do
        date = Date.current
        paid_leave = create(:paid_leave)
        create(:approval, paid_leave: paid_leave,
               acquisition_date: date + 1.month,
               paid_applicable: true,
               paid_confirm: true)
        create(:approval, paid_leave: paid_leave,
               acquisition_date: date + 13.months,
               paid_applicable: true,
               paid_confirm: true)

        expect(paid_leave.paid_achievements).to eq(1)
      end
    end

    context 'base_dateがnilの場合' do
      it 'nilを返す' do
        paid_leave = build(:paid_leave)
        paid_leave.base_date = nil

        expect(paid_leave.paid_achievements).to be_nil
      end
    end
  end

  describe 'remaining_leave_daysのテスト' do
    context '情報が正常に保存されている場合' do
      it '有給休暇（特休除く）の残日数を正しく集計する' do
        paid_leave = create(:paid_leave)
        grant = create(:grant, paid_leave: paid_leave)

        create_list(:approval, 3, paid_leave: paid_leave, paid_applicable: true, paid_confirm: true)
        # create(:approval, paid_leave: paid_leave, paid_applicable: false, paid_confirm: true) ←計算ロジックを移すまでコメントアウト

        expect(paid_leave.remaining_leave_days).to eq(17)
      end
    end

    context '承認がない場合' do
      it 'granted_pieceを返す' do
        paid_leave = create(:paid_leave)
        grant = create(:grant, paid_leave: paid_leave)

        expect(paid_leave.remaining_leave_days).to eq(20)
      end
    end

    context 'grantがnilの場合' do
      it '0を返す' do
        paid_leave = create(:paid_leave)
        paid_leave.grant = nil

        expect(paid_leave.remaining_leave_days).to eq(0)
      end
    end
  end

  describe 'paid_totalling(month)のテスト' do
    context '情報が正常に保存されている場合' do
      it '指定された月の承認数を正しく集計する' do
        paid_leave = create(:paid_leave)
        grant = create(:grant, paid_leave: paid_leave)

        today = Date.today

        create(:approval, paid_leave: paid_leave, paid_applicable: true, paid_confirm: true)
        create(:approval, paid_leave: paid_leave, acquisition_date: today + 1.month, paid_applicable: true, paid_confirm: true)

        expect(paid_leave.paid_totalling(today.month)).to eq(1)
      end
    end

    context 'grantがnilの場合' do
      it 'nilを返す' do
        paid_leave = create(:paid_leave)
        paid_leave.grant = nil

        expect(paid_leave.paid_totalling(Date.today.month)).to be_nil
      end
    end
  end
end
