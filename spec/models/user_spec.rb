require 'rails_helper'
# bundle exec rspec spec/models/user_spec.rb

RSpec.describe User, type: :model do
  it { should have_one(:paid_leave).dependent(:destroy) }
  it { should have_many(:requests).dependent(:destroy) }
  it { should have_one(:grant).dependent(:destroy) }
  it { should have_many(:approvals).dependent(:destroy) }
  it { should have_one(:car).dependent(:destroy) }
  it { should have_many(:drive_be_logs).dependent(:destroy) }
  it { should have_many(:drive_af_logs).dependent(:destroy) }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :department }
  it { is_expected.to validate_length_of(:name).is_at_most(255) }
  it { is_expected.to validate_length_of(:email).is_at_most(255) }
  it { is_expected.to allow_value("true").for(:is_admin) }
  it { is_expected.to allow_value("false").for(:is_admin) }
  it { is_expected.not_to allow_value(nil).for(:is_admin) }

  describe 'admin?のテスト' do
    context 'ログインユーザーが管理者の時' do
      it 'is_adminがtrueであること' do
        user = build(:user, is_admin: true)
        expect(user.admin?).to be true
      end
    end

    context 'ログインユーザーが管理者でない時' do
      it 'is_adminがfalseであること' do
        user = build(:user, is_admin: false)
        expect(user.admin?).to be false
      end
    end
  end

  describe 'years_of_serviceのテスト' do
    context 'データの保存に成功した時' do
      it '正しい勤続年数を計算する' do
        user = create(:user)
        paid_leave = create(:paid_leave, user: user, joining_date: Date.new(2020, 4, 1), base_date: Date.new(2025, 4, 1))
        expect(user.years_of_service).to eq(5.0)
      end
    end
  end

  describe 'full_time_planのテスト' do
    context '正社員の時' do
      it '勤続年数が0.5年から1.5年未満の場合、有給の数を10日間で返す' do
        user = build(:user)
        allow(user).to receive(:years_of_service).and_return(1.0)
        expect(user.full_time_plan).to eq(10)
      end

      it '勤続年数が6.5年以上の場合、有給の数を20日間で返す' do
        user = build(:user)
        allow(user).to receive(:years_of_service).and_return(7.0)
        expect(user.full_time_plan).to eq(20)
      end
    end
  end

  describe 'part_time_planのテスト' do
    context 'パート勤務の時' do
      it '4日/週勤務かつ勤続年数が2.0年の場合、有給の数を8日間で返す' do
        user_2 = build(:user_2)
        allow(user_2).to receive(:years_of_service).and_return(2.0)
        expect(user_2.part_time_plan("4days_w")).to eq(8)
      end

      it '3日/週勤務かつ勤続年数が4.0年の場合、有給の数を8日間で返す' do
        user_2 = build(:user_2)
        allow(user_2).to receive(:years_of_service).and_return(2.0)
        expect(user_2.part_time_plan("4days_w")).to eq(8)
      end

      it '勤務形態が不明な場合は有給の数を0日で返す' do
        user_2 = build(:user_2)
        allow(user_2).to receive(:years_of_service).and_return(2.0)
        expect(user_2.part_time_plan("4days_w")).to eq(8)
      end
    end
  end
end
