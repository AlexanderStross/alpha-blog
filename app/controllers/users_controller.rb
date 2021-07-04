class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy, :toggle_admin]
    before_action :require_user, only: [:edit, :update]
    before_action :require_same_user, only: [:edit, :update, :destory]

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Your account informatoin was successfully updated"
      redirect_to user_path(current_user)
    else
      render 'edit'
    end
  end

  def create
    unless !!User.first
      @user = User.new(admin_params)
    else
      @user = User.new(user_params)
    end
    if @user.save
      if !@user.admin?
        flash[:success] = "Welcome to the Alpha Blog #{@user.username}, you have successfuly signed up"
      else
        flash[:success] = "Welcome to the Alpha Blog #{@user.username}, you have successfuly created your Admin account"
      end
      session[:user_id] = @user.id
      redirect_to articles_path
    else
      render 'new'
    end
  end

def destroy
  unless @user.admin? && (User.where(:admin => true).count < 2)
    @user.destroy
    session[:user_id] = nil unless @uwer == current_user
    flash[:success] = "Account and all associated artciles have been deleted"
    redirect_to articles_path
  else
    flash[:danger] = "You may not detroy your account as you are the only administrator"
    redirect_to request.referrer
  end
end

def toggle_admin
    @user.toggle!(:admin)
end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, admin: true)
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:warning] = "You can only edit or delete your own account"
      redirect_to @user
    end
  end

end
