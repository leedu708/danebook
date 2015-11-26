require 'rails_helper'

RSpec.describe NewsfeedsController, type: :controller do


  describe 'GET #show' do

    context "current user's newsfeed" do

      let(:user) { create(:user) }
      let(:friend) { create(:user) }

      before do
        request.cookies[:auth_token] = user.auth_token
        user.friended_users << friend
        get :show, :user_id => user.id
      end

      it 'assigns @user to current user' do
        expect(assigns[:user]).to eq(user)
      end

      it 'collects latest posts from friends into @posts' do
        posts = create_list(:post, 2, :author_id => friend.id)

        # dummy post that should not be pulled
        create(:post)

        expect(assigns[:posts].size).to eq(2)
        expect(posts).to include(assigns[:posts].first)
      end

      it { should render_template('show') }

    end

    context "other user's newsfeed" do

      let(:user) { create(:user) }
      let(:other_user) { create(:user) }

      before do
        request.cookies[:auth_token] = user.auth_token
      end

      it "prevents viewing another user's feed" do
        get :show, :user_id => other_user.id
        expect(flash[:danger]).to eq("Unauthorized Access!")
        expect(response).to redirect_to(root_path)
      end

    end

  end

end