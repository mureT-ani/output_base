require 'rails_helper'

RSpec.describe Good, type: :model do
  describe '高評価機能' do
    before do
      @good = FactoryBot.build(:good)
    end

    context '高評価できる場合' do
      it 'ユーザーと投稿があれば高評価できること' do
        expect(@good).to be_valid
      end
    end

    context '高評価できない場合' do
      it 'ユーザーが空だと高評価できないこと' do
        @good.user = nil
        @good.valid?
        expect(@good.errors.full_messages).to include('User must exist')
      end

      it '投稿が空だと高評価できないこと' do
        @good.post = nil
        @good.valid?
        expect(@good.errors.full_messages).to include('Post must exist')
      end

      it '同じユーザーは同じ投稿を高評価できないこと' do
        @good.save
        anoter_good = FactoryBot.build(:good, user_id: @good.user_id, post_id: @good.post_id)
        anoter_good.valid?
        expect(anoter_good.errors.full_messages).to include('Post has already been taken')
      end

    end
  end
end
