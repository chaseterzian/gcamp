class RegistrationsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.create(params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmtion))
    if @user.save
      session[:user_id] = @user.id
      flash[:message] = "You have successfully signed up"      
      redirect_to new_project_path
    else
      render :new
    end
  end




end
