class UsersController < ApplicationController

  before_action :require_current_user, :except => [:new, :create, :show]

  def new

    @user = User.new
    @user.build_profile

  end

  def show

    @user = User.find(params[:id])

  end

  def edit

    @user = current_user

  end

  def update

    if current_user.update(update_params)
      flash[:success] = 'Profile successfully updated!'
      redirect_to current_user
    else
      flash.now[:danger] = 'Profile failed to update'
      @user = current_user
      render :edit
    end

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

  def update_params

    params.require(:user).
           permit({:profile_attributes => [ :id,
                                            :college,
                                            :hometown,
                                            :currently_lives,
                                            :telephone,
                                            :words_to_live_by,
                                            :description ] } )

  end

  def require_current_user

    unless params[:id] == current_user.id.to_s
      flash[:danger] = "Unauthorized Access"
      redirect_to root_url
    end

  end
  
end
