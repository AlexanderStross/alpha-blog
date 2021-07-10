class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?, :promote_to_admin, :get_featured_Categories
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    unless logged_in?
      flash[:warning] = 'You must be logged in to perform that action'
      redirect_to login_path
    end
  end

  def get_featured_Categories
    @fcs = Category.where(featured: true)
  end
end
