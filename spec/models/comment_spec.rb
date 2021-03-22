require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'コメント投稿機能' do
    before do
      @comment = FactoryBot.build(:comment)
    end
    context 'コメントが投稿できる場合' do
      it 'テキストがあれば投稿できること' do
        expect(@comment).to be_valid
      end
    end
    context 'コメントが投稿できない場合' do
      it 'テキストが空だと投稿できないこと' do
        @comment.comment_text = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Comment text can't be blank")
      end

      it 'テキストが200文字より多いと投稿できないこと' do
        @comment.comment_text = Faker::Lorem.characters(number: 201)
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Comment text is too long (maximum is 200 characters)')
      end

      it 'ユーザーが空だと投稿できないこと' do
        @comment.user = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('User must exist')
      end

      it '投稿が空だと投稿できないこと' do
        @comment.post = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Post must exist')
      end
    end
  end
end
