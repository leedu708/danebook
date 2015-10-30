class UsersController < ApplicationController

  def new

    @user = User.new

  end

  def create

    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      flash[:success] = "User successfully created!"
      redirect_to root_url
    else
      flash.now[:danger] = "User failed to be created."
      render :new
    end

  end

  private

  def user_params

    params.require(:user).permit(:email, 
                                 :password, 
                                 :password_confirmation,
                                 { :profile_attributes => [:first_name, :last_name, :birthdate, :gender] } )

  end
  
end
