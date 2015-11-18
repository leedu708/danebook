require 'rails_helper'

describe PostsController do

  describe 'GET #index' do

    let(:viewed_user) { create(:user) }
    let(:logged_in_user) { create(:user) }
    let(:post_count) { 2 }

    before do
      post_count.times { viewed_user.posts << build(:post, :author => viewed_user) }
      request.cookies[:auth_token] = logged_in_user.auth_token
    end

    it 'assigns @user to User being viewed (not current user)' do
      get :index, :user_id => viewed_user
      expect(assigns(:user)).to eq(viewed_user)
    end

    it "gathers all of user's posts into @posts" do
      get :index, :user_id => viewed_user
      expect(assigns(:posts).size).to eq(post_count)
      expect(assigns(:posts)).to eq(viewed_user.posts)
    end

    it 'assigns @new_post with current_user id if signed in' do
      get :index, :user_id => viewed_user
      expect(assigns(:new_post)).to be_a_new(Post)
      expect(assigns(:new_post).author).to eq(logged_in_user)
    end

  end

  describe 'POST #create' do

    let(:malicious_user) { create(:user) }
    let(:attacked_user) { create(:user) }

    before do
      request.cookies[:auth_token] = malicious_user.auth_token
    end

    it 'rejects when author_id in params is not current_user' do
      # create a dummy post to prevent false positives below
      create(:post)

      test_post = "Malicious post"

      post :create, :user_id => attacked_user.id,
                    :post => attributes_for(:post,
                                            :body => test_post,
                                            :author_id => attacked_user.id)

      expect(flash[:danger]).to eq("Unauthorized Access!")

      last_post = Post.last
      expect(last_post.author).not_to eq(attacked_user)
      expect(last_post.body).not_to eq(test_post)
    end

  end

end