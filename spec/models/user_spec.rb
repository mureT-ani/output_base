require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end

    context '登録できる場合' do
      it 'ニックネーム、メールアドレス、パスワード、パスワード（確認用）、職業、生年月日が存在すれば登録できること' do
        expect(@user).to be_valid
      end
    end
    context '登録できない場合' do
      it 'ニックネームが存在しないと登録できないこと' do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'メールアドレスが存在しないと登録できないこと' do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'メールアドレスに＠がないと登録できないこと' do
        @user.email = 'emailaddress'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'すでに登録されているメールアドレスでは登録できないこと' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'パスワードが存在しないと登録できないこと' do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'パスワードが５文字以下だと登録できないこと' do
        @user.password = '1234a'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'パスワード（確認用）がパスワードと一致しないと登録できないこと' do
        @user.password = '12345a'
        @user.password_confirmation = '12345b'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it '職業で---(id:1)を選択すると出品できないこと' do
        @user.job_id = 1
        @user.valid?
        expect(@user.errors.full_messages).to include('Job must be other than 1')
      end

      it '職業が空白だと出品できないこと' do
        @user.job_id = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Job can't be blank")
      end

      it '生年月日が存在しないと登録できないこと' do
        @user.birthday = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
