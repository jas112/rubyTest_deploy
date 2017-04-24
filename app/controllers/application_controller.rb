class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :require_login, except: [:new, :create]

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  private
  def require_login
    unless logged_in
      flash[:error] = "You must be logged in to access this section"
      redirect_to "/main"
    end
  end

  def logged_in
    !!current_user
  end

  def user_authorization
    @user = User.find(params[:id])
    redirect_to "/shoes" unless current_user === @user
    # redirect_to "/users/#{current_user.id}" unless current_user === @user
  end

end
