require 'rails_helper'

feature 'Liking Posts' do

  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:like_link) { "/likes?liked_id=#{post.id}&liked_type=Post" }

  before do
    sign_in(user)
  end

  scenario 'like an unliked Post' do
    visit user_posts_path(post.author)

    click_link 'Like', href: like_link

    expect(page.current_path).to eq(user_posts_path(post.author))
    expect(page).to have_content('Liked!')
    expect(page).not_to have_link('Like', href: like_link)
    expect(page).to have_link('Unlike', href: like_path(Like.last.id))
  end

  scenario 'unliking a liked Post' do
    post.likers << user
    visit user_posts_path(post.author)

    click_link 'Unlike', href: like_path(Like.last.id)

    expect(page.current_path).to eq(user_posts_path(post.author))
    expect(page).to have_content('Unliked!')
    expect(page).not_to have_link('Unlike')
    expect(page).to have_link('Like', href: like_link)
  end

end

feature 'Liking Comments' do

  let(:user) { create(:user) }
  let(:comment) { create(:comment, :on_post) }
  let(:like_link) { "/likes?liked_id=#{comment.id}&liked_type=Comment" }

  before do
    sign_in(user)
  end

  scenario 'like an unliked Comment' do
    visit user_posts_path(comment.commentable.author)

    click_link 'Like', href: like_link

    expect(page.current_path).to eq(user_posts_path(comment.commentable.author))
    expect(page).to have_content('Liked!')
    expect(page).not_to have_link('Like', href: like_link)
    expect(page).to have_link('Unlike', href: like_path(Like.last.id))
  end

  scenario 'unlike a liked Comment' do
    comment.likers << user
    visit user_posts_path(comment.commentable.author)

    click_link 'Unlike', href: like_path(Like.last.id)

    expect(page.current_path).to eq(user_posts_path(comment.commentable.author))
    expect(page).to have_content('Unliked!')
    expect(page).not_to have_link('Unlike')
    expect(page).to have_link('Like', href: like_link)
  end

end