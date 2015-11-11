require 'rails_helper'

feature 'Edit User Profile' do

  let(:user) { create(:user, :profile => build(:base_profile)) }
  let(:full_profile_fields) { build(:full_profile) }

  before do
    sign_in(user)
    visit(user_path(user))
    click_link 'Edit your profile'
  end

  scenario 'with valid input' do
    fill_out_user_profile(full_profile_fields)

    click_button 'Save Changes'

    expect(page).to have_content 'Profile successfully updated!'
    expect(page).to have_content full_profile_fields.hometown
    expect(page.current_path).to eq(user_path(user))
  end

  scenario 'with valid blank input' do
    fill_out_user_profile(full_profile_fields)

    fill_in 'user_profile_attributes_telephone', with: ""

    click_button 'Save Changes'

    expect(page).to have_content 'Profile successfully updated!'
    expect(page).to have_content full_profile_fields.hometown
    expect(page).not_to have_content full_profile_fields.telephone
    expect(page.current_path).to eq(user_path(user))
  end

  scenario 'as an unauthorized user' do
    bad_user = create(:user, :profile => full_profile_fields)
    visit edit_user_path(bad_user)

    expect(page).to have_content 'Unauthorized Access'
    expect(page.current_path).to eq(root_path)
  end

end