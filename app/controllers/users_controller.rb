class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy toggle_admin]
  before_action :require_user, only: %i[edit update]
  before_action :require_same_user, only: %i[edit update destory]
  before_action :get_all_categories, only: %i[show contributors index]

  caches_action :index

  def show
    @articles = if params[:category]
                  Category.find_by_slug(params[:category]).articles.where(user_id: @user.id).paginate(page: params[:page],
                                                                                                      per_page: 5)
                else
                  @user.articles.paginate(page: params[:page], per_page: 5)
                end
    @alluserarticles = @user.articles
  end

  def contributors
    @users = User.where('user_role >= 1').paginate(page: params[:page],
                                                   per_page: 5)
  end

  def index
    @users = User.order(:username).paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = 'Your account informatoin was successfully updated'
      redirect_to user_path(current_user)
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)
    @user.admin = true unless !!User.first
    if @user.save
      flash[:success] = if !@user.admin?
                          "Welcome to the Alpha Blog #{@user.username}, you have successfuly signed up"
                        else
                          "Welcome to the Alpha Blog #{@user.username}, you have successfuly created your Admin account"
                        end
      session[:user_id] = @user.id
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def destroy
    if @user.admin? && (User.where(admin: true).count < 2)
      flash[:danger] = 'You may not detroy your account as you are the only administrator'
      redirect_to request.referrer
    else
      @user.destroy
      session[:user_id] = nil unless @user != current_user
      flash[:success] = 'Account and all associated artciles have been deleted'
      redirect_to articles_path
    end
  end

  def toggle_admin
    @user.toggle!(:admin)
  end

  private

  def get_all_categories
    @categories = Category.all
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.friendly.find(params[:id])
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:warning] = 'You can only edit or delete your own account'
      redirect_to @user
    end
  end
end
