require 'rails_helper'

RSpec.describe Message, type: :model do
  describe '#create' do
    #メッセージ保存できる場合集
    context 'can save' do
      #1 テキストあれば保存できるか
      it 'is valid with text' do
        expect(build(:message, image: nil)).to be_valid
      end

      #2画像あれば保存できるか
      it 'is valid with image' do
        expect(build(:message, text: nil)).to be_valid
      end

      #3テキストと画像両方あっても保存できるか
      it 'is valid with text and image' do
        expect(build(:message)).to be_valid
      end
    end
    #メッセージ保存できないのが正しい場合集
    context 'can not save' do
      #4両方ない場合はちゃんとエラーになるか
      it 'is invalid without text and image' do
        message = build(:message, text: nil, image: nil)
        message.valid?
        expect(message.errors[:text]).to include("を入力してください")
      end

      #5グループIDない場合ちゃんと投稿はできていないか
      it 'is invalid without group_id' do
        message = build(:message, group_id: nil)
        message.valid?
        expect(message.errors[:group]).to include("を入力してください")
      end

      #6useridない場合ちゃんと保存はされていないようになっているか
      it 'is invaid without user_id' do
        message = build(:message, user_id: nil)
        message.valid?
        expect(message.errors[:user]).to include("を入力してください")
      end
    end
  end
end