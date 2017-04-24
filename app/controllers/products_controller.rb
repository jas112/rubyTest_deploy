class ProductsController < ApplicationController
  def index
    @user = User.find(session[:user_id])
    @products = Product.all
    render layout: "three_column"
  end

  def create
    @user = User.find(current_user.id)
    @product = Product.new(product_params)
    if @product.save
      redirect_to "/dashboard/#{@user.id}"
    else
      flash[:errors] = @product.errors.full_messages
    end
  end

  def destroy
    @product = Product.find(params[:id])
    if @product.destroy
      redirect_to :back
    else
      flash[:errors] = @product.errors.full_messages
    end
  end

  private
  def product_params
    params.require(:product).permit(:name, :price).merge(user: current_user)
  end
end
