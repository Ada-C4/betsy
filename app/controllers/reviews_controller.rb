class ReviewsController < ApplicationController
  before_action :find_review, only: [:show, :update, :destroy]
  before_action :find_product, only: [:new, :update, :create]

  def index
    @reviews = Review.all
    @product = Product.find(params[:product_id])
  end


  def show
  end

  # Since guests can create a review, nobody (for now) can edit it. Maybe for admin user later...
  # def edit
  # end


  def create
    @review = Review.create(review_params) do |r|
      r.product_id = params[:product_id]
    end
    if @review.save
      redirect_to user_product_path(@review.product.user, @review.product)
    else
      flash[:error] = @review.errors.full_messages.first
      redirect_to user_product_path(@review.product.user, @review.product)
    end
  end


  def update
    if @review.update(review_params)
      redirect_to user_product_reviews_path(@review.product.user, @review.product)
    else
      render :edit
    end
  end


  def destroy
    @review.destroy
    redirect_to user_product_reviews_path(@review.product.user, @review.product)
  end

  private

    def review_params
      params.require(:review).permit(:rating, :description)
    end

    def find_review
      @review = Review.find(params[:id])
    end

    def find_product
      @product = Product.find(params[:product_id])
    end
end
