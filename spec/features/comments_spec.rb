require 'rails_helper'

feature 'Comment on a post' do

  let(:user) { create(:user) }
  let(:post) { create(:post) }

  before do
    sign_in(user)
    visit user_posts_path(post.author)
  end

  scenario 'with valid content length of at most 140 chars' do
    text = "d" * 140
    fill_in 'comment_body', with: text
    click_button 'Comment'

    expect(page).to have_content text
    expect(page).to have_content "Comment successfully created!"
    expect(page.current_path).to eq(user_posts_path(post.author))
  end

  scenario 'with content that is greater than 140 chars' do
    text = "d" * 141
    fill_in 'comment_body', with: text
    click_button 'Comment'

    expect(page).not_to have_content text
    expect(page).to have_content "Comment failed to save - please try again."
    expect(page.current_path).to eq(user_posts_path(post.author))
  end

  scenario 'with blank input' do
    text = ""
    fill_in 'comment_body', with: text
    click_button 'Comment'

    expect(page).to have_content "Comment failed to save - please try again."
    expect(page.current_path).to eq(user_posts_path(post.author))
  end

  scenario 'as unauthorized User' do
    sign_out
    visit(user_posts_path(post.author))

    expect(page).not_to have_button('Comment')
  end

end