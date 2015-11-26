class CoverPhotosController < ApplicationController

  before_action :require_current_user

  def update

    @user = User.find(params[:user_id])
    @photo = Photo.find(params[:photo_id])
    @user.cover_photo = @photo

    if @user.save
      flash[:success] = 'Cover photo updated!'
      redirect_to user_path(@user)
    else
      flash.now[:warning] = 'Cover photo failed to update - please try again.'
      redirect_back_or_to(user_photo_path(@photo))
    end

  end

  private

  def require_current_user

    unless params[:user_id] == current_user.id.to_s
      flash[:danger] = "Unauthorized Access"
      redirect_to user_photos_path(params[:user_id])
    end

  end

end
