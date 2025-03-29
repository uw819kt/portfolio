require 'rails_helper'
# bundle exec rspec spec/models/car_spec.rb

RSpec.describe '車両番号登録機能', type: :model do
  let!(:user) { FactoryBot.create(:user) }
  describe 'バリデーションのテスト' do
    context '所有者が紐づいてない場合' do
      it 'バリデーションに失敗する' do
        car = Car.create(company_car: "下関111あ1111", private_car: "")
        expect(car).not_to be_valid
      end
    end

    context '所有者が紐づいている場合' do
      it '車両番号を登録できる' do
        car = Car.create(company_car: "下関111あ1111", private_car: "", user: user)
        expect(car).to be_valid
      end
    end
  end
end