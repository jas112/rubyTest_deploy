class UsersController < ApplicationController

  def new
  end

  def create
    if params[:user][:password] == params[:user][:password_confirmation]
      @user = User.new(user_params)
      if @user.save
        redirect_to "/main"
      else
        flash[:errors] = @user.errors.full_messages
        redirect_to "/main"
      end
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to "/main"
    end
  end

  def show
    @user = User.find(params[:id])
    @products = @user.products.joins(:user)
    @sales = @user.sales
    @purchases = @user.transactions
    @sales_total = @sales.inject(0){ |sum, sale| sum + sale.product.price }
    @purchases_total = @purchases.inject(0){ |sum, purchase| sum + purchase.product.price }
    render layout: "three_column"
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end
