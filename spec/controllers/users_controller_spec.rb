require 'rails_helper'

describe UsersController do

  describe 'PATCH #update' do

    let(:tester) { create(:user) }
    let(:attacked_user) { create(:user) }

    before do
      tester
      # add the cookies sent in with the response to contain our authenticity token
      request.cookies[:auth_token] = tester.auth_token
    end

    it 'allows a user to edit his own profile' do
      updated_info = 'School of Updates'
      put :update, :id => tester.id,
                   :user => attributes_for(:user,
                                           :profile_attributes => { :college => updated_info, :id => tester.profile.id } )

      tester.reload
      expect(tester.profile.college).to eq(updated_info)
      expect(flash[:success]).to eq('Profile successfully updated!')
    end

    it 'rejects when user_id in params is not current_user' do
      bad_update = 'School of Hacked'
      put :update, :id => attacked_user.id,
                   :user => attributes_for(:user,
                                           :profile_attributes => { :college => bad_update, :id => attacked_user.profile.id } )

      attacked_user.reload
      expect(attacked_user.profile.college).not_to eq(bad_update)
      expect(flash[:danger]).to eq("Unauthorized Access")
    end

  end

end