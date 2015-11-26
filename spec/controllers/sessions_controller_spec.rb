require 'rails_helper'

describe SessionsController do

  describe 'POST #create' do

    let(:user) { create(:user) }

    context 'when given valid login credentials' do

      before do
        post:create, :email => user.email, :password => user.password
      end

      it 'assigns @user properly' do
        expect(assigns(:user)).to eq(user)
      end

      it 'flashes the successful sign in message' do
        expect(flash[:success]).to eq("You have successfully signed in!")
      end

      it 'redirects to user newsfeed' do
        expect(response).to redirect_to user_newsfeed_path(user)
      end

    end

    context 'when given invalid login credentials' do

      before do
        post :create, :email => user.email, :password => 'badpass'
      end

      it 'flashes unsuccessful login message' do
        expect(flash[:danger]).to eq("You have failed to sign in.")
      end

      it 'redirects to root' do
        expect(response).to redirect_to root_path
      end

    end

  end

end