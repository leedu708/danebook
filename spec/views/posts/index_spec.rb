require 'rails_helper'

describe "posts/index.html.erb" do

  let(:user) { create(:user) }
  before do
    assign(:user, user)
    assign(:posts, Array.new(2) { create(:post, :author => user) } )
    assign(:new_post, Post.new(:author_id => user.id) )

    def view.signed_in_user?
      true
    end
  end

  context "when on current user's page" do

    before do
      def view.current_user
        @user
      end
    end

    it "only renders New Post form if on current_user's page" do
      render
      expect(rendered).to match('Tell the world something')
    end

  end

  context "when not on current user's page" do

    before do
      def view.current_user
        nil
      end
    end

    it "does not render New Post form not on current_user's page" do
      render
      expect(rendered).not_to match('Tell the world something')
    end

  end

end