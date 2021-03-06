class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "log in successful"
      redirect_to user
    else
      flash.now[:danger] = "There was something wrong with your login credentials"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You are logged out"
    redirect_to articles_path
  end
end
