require 'rails_helper'

describe Comment do

  let(:comment) { build(:comment) }

  it 'saves with valid attributes' do
    expect(comment).to be_valid
  end

  context 'Validating body input' do

    it 'saves if body is at least 1 char' do
      comment.body = "d"
      expect(comment).to be_valid
    end

    it 'fails to save if body less than 1 char' do
      comment.body = ""
      expect(comment).to be_invalid
    end

    it 'saves if body is at most 140 chars' do
      comment.body = "d" * 140
      expect(comment).to be_valid
    end

    it 'fails to save if body is greater than 140 chars' do
      comment.body = "d" * 141
      expect(comment).to be_invalid
    end

  end

  context 'Deleting comments' do

    let(:like) { build(:comment_like) }
    it 'deletes dependent Likes with no orphans' do
      like.liked.destroy
      expect { like.reload }.to raise_exception(ActiveRecord::RecordNotFound)
    end

  end

end