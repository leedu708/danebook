class SessionsController < ApplicationController

  def new

    redirect_to root_url

  end

  def create

    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      sign_in(@user)
      flash[:success] = "You have successfully signed in!"
      redirect_to user_posts_path(@user)
    else
      flash[:danger] = "You have failed to sign in."
      redirect_to root_url
    end

  end

  def destroy

    sign_out
    flash[:success] = "Successfully signed out!"
    redirect_to root_url

  end

end
