require 'rails_helper'

describe Post do

  context 'Deleting posts' do

    let(:post) { create(:post) }
    let(:comment) { build(:comment) }
    let(:like) { build(:post_like) }

    before do
      post.comments << comment
      post.likes << like
      post.destroy
    end

    it 'should delete dependent comments with no orphans' do
      expect_destroyed_orphan(comment)
    end

    it 'should delete likes with no orphans' do
      expect_destroyed_orphan(like)
    end

  end

end