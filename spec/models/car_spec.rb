require 'rails_helper'
# bundle exec rspec spec/models/car_spec.rb

RSpec.describe Car, type: :model do
  it { should belong_to(:user) }

  it { is_expected.to validate_length_of(:company_car).is_at_most(30) }
  it { is_expected.to validate_length_of(:private_car).is_at_most(30) }

  describe 'カスタムバリデーションのテスト' do
    context '車両番号の形式が不正な場合' do
      it '無効であること' do
        car = FactoryBot.build(:car_2)

        expect(car.valid?).to be_falsey
        expect(car.errors[:base]).to include("車両番号の形式が不正です（例: 下関500あ1234）")
      end
    end

    context '車両番号の形式が正しい場合' do
      it '有効であること' do
        car = FactoryBot.build(:car)

        expect(car.valid?).to be_truthy
      end
    end
  end
end
