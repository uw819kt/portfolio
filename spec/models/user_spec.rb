require 'rails_helper'
# bundle exec rspec spec/models/user_spec.rb

RSpec.describe '社員情報登録機能', type: :model do
  describe 'バリデーションのテスト' do
    context '登録フォームの名前が空文字の場合' do
      it 'バリデーションに失敗する' do
        user = User.create(name: "", email: "admin@example.com", department: 0, password: "password", password_confirmation: "password", admin: true)
        expect(user).not_to be_valid
      end
    end

    context '登録フォームのメールアドレスが空文字の場合' do
      it 'バリデーションに失敗する' do
        user = User.create(name: "admin", email: "", department: 0, password: "password", password_confirmation: "password", admin: true)
        expect(user).not_to be_valid
      end
    end

    context '登録フォームの所属部署が空文字の場合' do
      it 'バリデーションに失敗する' do
        user = User.create(name: "admin", email: "admin@example.com", department: "", password: "password", password_confirmation: "password", admin: true)
        expect(user).not_to be_valid
      end
    end

    context '登録フォームのパスワードが空文字の場合' do
      it 'バリデーションに失敗する' do
        user = User.create(name: "admin", email: "admin@example.com", department: 0, password: "", password_confirmation: "", admin: true)
        expect(user).not_to be_valid
      end
    end

    context '登録フォームの全てに値が入っている場合' do
      it '社員情報を登録できる' do
        user = User.create(name: "admin", email: "admin@example.com", department: 0, password: "password", password_confirmation: "password", admin: true)
        expect(user).to be_valid
      end
    end
  end
end
