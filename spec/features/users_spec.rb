require 'rails_helper'

feature 'Create New User' do

  let(:new_user) { build(:user) }
  let(:profile) { build(:base_profile, user: new_user) }

  before do
    visit root_path
  end

  scenario 'with valid attributes' do

    # LoginMacros
    fill_out_new_user_form(new_user, profile)
    click_button 'Sign Up!'

    expect(page).to have_content 'User successfully created!'
    expect(page).to have_content new_user.email
    expect(page.current_path).to eq(user_posts_path(User.last))

  end

  scenario 'with invalid attributes' do

    profile.first_name = nil
    fill_out_new_user_form(new_user, profile)
    click_button 'Sign Up!'

    expect(page).to have_content 'User failed to be created.'
    expect(page).to have_content "First Name can't be blank"
    expect(page.current_path).to eq(users_path)

  end

  scenario 'if user email is not unique' do

    existing_user = create(:user)
    new_user.email = existing_user.email
    fill_out_new_user_form(new_user, profile)
    click_button 'Sign Up!'

    expect(page).to have_content 'User failed to be created.'
    expect(page).to have_content 'Email has already been taken'
    expect(page.current_path).to eq(users_path)

  end

end