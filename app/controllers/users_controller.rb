class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      successful_save
    else
      flash[:danger] = @user.errors.full_messages.join('. ')
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end

  def successful_save
    flash[:success] = "Welcome, #{@user.username}!"
    session[:user_id] = @user.id
    redirect_to landmarks_path
  end
end
