require 'rails_helper'

describe LikesController do

  describe 'POST #create' do

    let(:user) { create(:user) }

    before do
      request.cookies[:auth_token] = user.auth_token
      # HTTP_REFERER: the address that linked to this resource (back)
      request.env["HTTP_REFERER"] = user_posts_path(user)
    end

    context 'when Liked Object is a Post' do

      let(:liked_post) { create(:post) }

      it 'identifies Post as liked_type' do
        post :create, :liked_id => liked_post.id, :liked_type => 'Post'
        expect(assigns(:liked)).to be_a(Post)
      end

    end

    context 'when Liked Object is a Comment' do

      let(:liked_comment) { create(:comment) }

      it 'identifies Comment as liked_type' do
        post :create, :liked_id => liked_comment.id, :liked_type => 'Comment'
        expect(assigns(:liked)).to be_a(Comment)
      end

    end

  end

end