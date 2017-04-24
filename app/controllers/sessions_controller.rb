class SessionsController < ApplicationController

  layout "two_column", only: [:new]

  def new
  end

  def create #Log User in with authenticate -- generates flash messages errors
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to "/shoes"
    else
      flash[:errors] = ["Invalid Combination"]
      redirect_to "/main"
    end
  end

  def destroy #Logs User out -- sets session[:user_id] to null -- redirects to login page
    reset_session
    redirect_to "/main"
  end

end
