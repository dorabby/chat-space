require 'rails_helper'

describe MessagesController do
  let(:group) { create(:group) }
  let(:user) { create(:user) }

#インデックスアクションの確認
  describe '#index' do
#ログインしている場合
    context 'log in' do
      before do
        login user
        get :index, params: { group_id: group.id }
      end
#アクション内で定義しているインスタンス変数があるか
      it 'assigns @message' do
        expect(assigns(:message)).to be_a_new(Message)
      end

      it 'assigns @group' do
        expect(assigns(:group)).to eq group
      end
#該当するビューが描写されているのか
      it 'renders index' do
        expect(response).to render_template :index
      end
    end
#ログインしていない場合
    context 'not log in' do
      before do
        get :index, params: { group_id: group.id }
      end
#new_user_session_pathにリダイレクトできるか
      it 'redirects to new_user_session_path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

#クリエイトアクションの確認
  describe '#create' do
    let(:params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message) } }
#ログインしている場合
    context 'log in' do
      before do
        login user
      end
#ログインしているかつ保存に成功した場合
      context 'can save' do
        subject {
          post :create,
          params: params
        }
#メッセージの保存
        it 'count up message' do
          expect{ subject }.to change(Message, :count).by(1)
        end
#保存終わったら意図したページにもどってるか
        it 'redirects to group_messages_path' do
          subject
          expect(response).to redirect_to(group_messages_path(group))
        end
      end
#ログインしているかつ保存に失敗した場合
      context 'can not save' do
        let(:invalid_params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message, text: nil, image: nil) } }

        subject {
          post :create,
          params: invalid_params
        }
#メッセージの保存はされていないか
        it 'does not text up' do
          expect{ subject }.not_to change(Message, :count)
        end
#意図したページにもどっているか
        it 'renders index' do
          subject
          expect(response).to render_template :index
        end
      end
    end
#ログインしていない場合
    context 'not log in' do
#意図したページに戻っているか
      it 'redirects to new_user_session_path' do
        post :create, params: params
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end