class MerchantsController < ApplicationController
  before_action :require_login, only: [:home]

  def new
    @merchant = Merchant.new
  end

  def create
    @merchant = Merchant.new(strong_params)
      if @merchant.save
        session[:user_id] = @merchant.id
        redirect_to merchant_home_path(@merchant)
      else
        render :new
      end
  end

  def home
  end

  def show
    @merchant = Merchant.find(params[:id])
    @products = @merchant.products
    @retiredproducts = @products.where(status:"Retired")
  end

  private

  def strong_params
    params.require(:merchant).permit(:username, :email, :password, :password_confirmation)
  end
end
