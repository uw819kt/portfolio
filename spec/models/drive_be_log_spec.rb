require 'rails_helper'
# bundle exec rspec spec/models/alcohol_log_spec.rb

RSpec.describe 'アルコールログモデル機能', type: :model do
  let!(:user) { FactoryBot.create(:user) }
  let!(:car) { FactoryBot.create(:car) }
  describe 'バリデーションのテスト' do
    context 'アルコールログの運転前後が未選択の場合' do
      it 'バリデーションに失敗する' do
        alcohol_log  = AlcoholLog.create(check_time: "2025-02-05 11:48:11.568272000 +0000", confirmation: 0, detector_used: true, result: 0.00, condition: 0, log_remarks: "", user: user, car: car, driving_status: "")
        expect(alcohol_log).not_to be_valid
      end
    end

    context 'アルコールログの車両番号が未選択の場合' do
      it 'バリデーションに失敗する' do
        alcohol_log  = AlcoholLog.create(check_time: "2025-02-05 11:48:11.568272000 +0000", confirmation: "", detector_used: true, result: 0.00, condition: 0, log_remarks: "", user: user, driving_status: 0)
        expect(alcohol_log).not_to be_valid
      end
    end

    context 'アルコールログの確認方法が未選択の場合' do
      it 'バリデーションに失敗する' do
        alcohol_log  = AlcoholLog.create(check_time: "2025-02-05 11:48:11.568272000 +0000", confirmation: "", detector_used: true, result: 0.00, condition: 0, log_remarks: "", user: user, car: car, driving_status: 0)
        expect(alcohol_log).not_to be_valid
      end
    end

    context 'アルコールログの測定結果が空欄の場合' do
      it 'バリデーションに失敗する' do
        alcohol_log  = AlcoholLog.create(check_time: "2025-02-05 11:48:11.568272000 +0000", confirmation: 0, detector_used: true, result: "", condition: 0, log_remarks: "", user: user, car: car, driving_status: 0)
        expect(alcohol_log).not_to be_valid
      end
    end

    context 'アルコールログの指示/その他以外に値が入っている場合' do
      it 'バリデーションに成功する' do
        alcohol_log  = AlcoholLog.create(check_time: "2025-02-05 11:48:11.568272000 +0000", confirmation: 0, detector_used: true, result: 0.00, condition: 0, log_remarks: "", user: user, car: car, driving_status: 0)
        expect(alcohol_log).to be_valid
      end
    end
  end
end
