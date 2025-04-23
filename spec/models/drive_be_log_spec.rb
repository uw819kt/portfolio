require 'rails_helper'
# bundle exec rspec spec/models/drive_be_log_spec.rb

RSpec.describe DriveBeLog, type: :model do
  it { should belong_to(:car) }
  it { should belong_to(:user) }

  it { is_expected.to validate_presence_of :check_time }
  it { is_expected.to validate_presence_of :confirmation }
  it { is_expected.to validate_presence_of :result }
  it { is_expected.to validate_presence_of :condition }
  it { is_expected.to allow_value("true").for(:detector_used) }
  it { is_expected.to allow_value("false").for(:detector_used) }
  it { is_expected.not_to allow_value(nil).for(:detector_used) }
  it { is_expected.to validate_length_of(:log_remarks).is_at_most(30) }

  describe 'カスタムバリデーションのテスト' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:car) { FactoryBot.create(:car) }

    context '運転前の記録を入力していない場合' do
      let!(:drive_be_log) { FactoryBot.create(:drive_be_log) }

      it 'バリデーションに成功する' do
        expect(drive_be_log).to be_valid
      end
    end

    context '運転前の記録を入力している場合' do
      let!(:drive_be_log) {
        FactoryBot.create(:drive_be_log,
          user: user,
          check_time: Time.zone.now.change(hour: 10),
        )
      }

      it 'バリデーションに失敗し、エラーメッセージが含まれる' do
        drive_be_log_2 = DriveBeLog.new(
          user: user,
          check_time: Time.zone.now.change(hour: 15),
          confirmation: 0,
          detector_used: true,
          result: 0.00,
          condition: 0,
          log_remarks: ""
        )

        expect(drive_be_log_2).not_to be_valid
        expect(drive_be_log_2.errors[:base]).to include("本日はすでに運転記録（前）が登録されています")
      end
    end
  end
end
