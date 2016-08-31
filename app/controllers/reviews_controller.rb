class ReviewsController < ApplicationController
  def new
    @review = Review.new(product_id: params[:product_id])
  end

  def create
    @review = Review.create(review_params)
    @review.product_id = params[:product_id]
    if @current_user && @current_user.products.include?(@review.product)
      flash[:error] = "You aren't allowed to review your own products.  Stop being Slytherin."
      redirect_to product_path(@review.product_id)
    else
      if !@review.save
        render "new"
      else
        @review.save
        redirect_to product_path(@review.product_id)
      end
    end
  end

private

  def review_params
    params.require(:review).permit(:rating, :description)
  end
end
