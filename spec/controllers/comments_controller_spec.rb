require 'rails_helper'

describe CommentsController do

  describe 'POST #create' do

    let(:tester) { create(:user) }
    let(:other_user) { create(:user) }
    let(:parent_post) { create(:post) }

    before do
      request.cookies[:auth_token] = tester.auth_token
    end

    it 'does not allow the current user from changing the poster_id in params' do
      request.env["HTTP_REFERER"] = user_posts_path(other_user)
      create(:comment, :on_post)

      test_comment = "Test comment"
      post :create, :comment => attributes_for(:comment,
                                               :body => test_comment,
                                               :poster_id => other_user.id,
                                               :commentable_id => parent_post.id,
                                               :commentable_type => parent_post.class)

      created_comment = Comment.last

      expect(created_comment.poster).to eq(tester)
      expect(created_comment.body).to eq(test_comment)

    end

  end

  describe 'POST #destroy' do

    let(:comment) { create(:comment, :on_post) }

    it 'redirect to the Post that the deleted Comment was under' do
      delete :destroy, id: comment.id
      expect(response).to redirect_to user_posts_path(comment.commentable.poster)
    end

  end

end