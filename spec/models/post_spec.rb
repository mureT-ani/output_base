require 'rails_helper'

RSpec.describe Post, type: :model do

  describe 'アウトプット投稿' do

    before do
      @post = FactoryBot.build(:post)
    end

    context '投稿できる場合' do
      it 'テキストが空でなければ投稿できること' do
        expect(@post).to be_valid
      end
    end

    context '投稿できない場合' do
      it 'テキストが空だと投稿できないこと' do
        @post.post_text = nil
        @post.valid?
        expect(@post.errors.full_messages).to include("Post text is required")
      end
    end
  end
end
