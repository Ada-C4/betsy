class MerchantsController < ApplicationController
  before_action :require_user, only: [:edit, :show]
  before_action :redirect_if_logged_in, only: [:new, :create]

  def index
  end

  def new
    @merchant = Merchant.new
  end

  def create
  @merchant = Merchant.create(merchant_params)
    if @merchant.save
# makes it so they don't have to login after they sign up. Takes the session data so it can run the redirect.
      session[:merchant_id] = @merchant.id
      redirect_to merchant_path(@merchant)
    else
      flash[:error] = "Try again. Or you may already be a user. Try logging in."
      render :new
    end
  end

  def show
    id = @current_user.id
    @merchant = Merchant.find(id)
    @products = @merchant.products
    status = params[:sort]

    if status == "all" || status == nil
      @orders = @merchant.orders
    else
      @orders = @merchant.orders.where(status: status)
    end
    @all_orders = @merchant.orders
    @pending_revenue ||= 0
    @paid_revenue ||= 0
    @complete_revenue ||= 0
    @cancelled_revenue ||= 0
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def merchant_params
    params.require(:merchant).permit(:user_name, :email, :password, :password_confirmation)
  end
end
