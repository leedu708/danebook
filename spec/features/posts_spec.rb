require 'rails_helper'

feature 'Making a new Post' do

  let(:user) { create(:user) }

  before do
    sign_in(user)
    visit(user_posts_path(user))
  end

  scenario "with valid length of up to 300 chars" do
    text = "d" * 300
    fill_in 'post_body', with: text
    click_button 'Post'

    expect(page).to have_content text
    expect(page).to have_content "New post successfully created!"
    expect(page.current_path).to eq(user_posts_path(user))
  end

  scenario "with invalid body length greater than 300 chars" do
    text = "d" * 301
    fill_in 'post_body', with: text
    click_button 'Post'

    expect(page).to have_content "New post failed to save - please try again."
    expect(page.current_path).to eq(user_posts_path(user))
  end

  scenario "with blank body" do
    text = ""
    fill_in 'post_body', with: text
    click_button 'Post'

    expect(page).to have_content "New post failed to save - please try again."
    expect(page.current_path).to eq(user_posts_path(user))
  end

  scenario "as an unauthorized User" do
    bad_user = create(:user)
    visit(user_posts_path(bad_user))

    expect(page).not_to have_button('Post')
  end

end