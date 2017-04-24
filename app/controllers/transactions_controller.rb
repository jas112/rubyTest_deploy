class TransactionsController < ApplicationController

  def new
  end

  def create
    @user = User.find(session[:user_id])
    @buy = Transaction.new(user_id: current_user.id, product_id: params[:id])
    if @buy.save
      redirect_to "/dashboard/#{@user.id}"
    else
      flash[:errors] = @buy.errors.full_messages
    end
  end

end
