require 'rails_helper'

describe User do

  let(:user) { create(:user) }

  context 'Saving users' do

    it 'saves with valid attributes' do
      expect(user).to be_valid
    end

    context 'Email validations' do

      it 'fails to save an email if it does not contain @' do
        user.email = "aabb"
        expect(user).to be_invalid
      end

      it 'saves if the email contains @' do
        user.email = "aa@bb"
        expect(user).to be_valid
      end

    end

    context 'Password checks' do

      it 'saves a hashed password' do
        expect(user.password_digest).to be_truthy
      end

      it 'does not store the actual password in the database' do
        expect(user.password_digest).not_to match(/password/)
      end

      it 'translates the hashed password with authenticate' do
        expect(user.authenticate('password')).to eq(user)
      end

    end

    context 'Profile attributes' do

      let(:user_with_profile) { create(:user, :profile_attributes => attributes_for(:base_profile)) }

      it 'saves profile with user when attributes are valid' do
        expect(user_with_profile).to be_persisted
        expect(user_with_profile.profile).to be_persisted

        check_profile = build(:base_profile)

        expect(user_with_profile.profile.first_name).to eq(check_profile.first_name)
        expect(user_with_profile.profile.hometown).to eq(check_profile.hometown)
        expect(user_with_profile.profile.description).to eq(check_profile.description)

      end

      it 'does not save a profile with invalid attributes' do

        invalid_atts = attributes_for(:base_profile, :first_name => nil)
        expect{ create(:user, :profile_attributes => invalid_atts) }.to raise_exception(ActiveRecord::RecordInvalid)

      end

    end

    context 'Deleting Users' do

      let(:profile) { build(:base_profile) }
      let(:post) { build(:post) }
      let(:comment) { build(:comment) }
      let(:like) { build(:post_like) }

      before do
        profile.user = user
        user.posts << post
        user.comments << comment
        user.likes << like
        user.destroy
      end

      it 'should delete dependent Profile with no orphans' do
        expect_destroyed_orphan(profile)
      end

      it 'should delete dependent Posts with no orphans' do
        expect_destroyed_orphan(post)
      end

      it 'should delete dependent Comments' do
        expect_destroyed_orphan(comment)
      end

      it 'should delete dependent Likes by that user with no orphans' do
        expect_destroyed_orphan(like)
      end

    end

  end

end