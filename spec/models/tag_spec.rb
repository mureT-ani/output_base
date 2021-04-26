require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'タグ作成' do
    before do
      @tag = FactoryBot.build(:tag)
    end

    context '作成出来る場合' do
      it '名前が空でなければ作成できること' do
        expect(@tag).to be_valid
      end
    end

    context '作成できない場合' do
      it '名前が空だと作成できないこと' do
        @tag.name = nil
        @tag.valid?
        expect(@tag.errors.full_messages).to include("Name can't be blank")
      end

      it '名前がすでに存在すると作成できないこと' do
        @tag.save
        new_tag = FactoryBot.build(:tag, name: @tag.name)
        new_tag.valid?
        expect(new_tag.errors.full_messages).to include('Name has already been taken')
      end
    end
  end
end
