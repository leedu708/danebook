class FriendsController < ApplicationController

  before_action :require_login, :except => [:index]

  def index

    @user = User.find(params[:user_id])
    @friends = @user.friended_users

  end

  def create

    # given recipient ID from view and shovels into current_user friended users
    recipient = User.find(params[:recipient_id])
    if current_user.friended_users << recipient
      flash[:success] = "You have added #{recipient.profile.full_name} as a friend!"
    else
      flash[:error] = "Failed to add friend - please try again."
    end

    redirect_to :back

  end

  def destroy

    recipient = User.find(params[:id])
    if current_user.friended_users.delete(recipient)
      flash[:warning] = "You have unfriended #{recipient.profile.full_name}."
    else
      flash[:error] = "Failed to unfriend - please try again."
    end

    redirect_to :back

  end
  
end
