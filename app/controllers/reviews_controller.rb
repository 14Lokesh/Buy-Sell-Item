# frozen_string_literal: true

# This is a sample class representing an  Review controller.
class ReviewsController < ApplicationController
  before_action :require_user_logged_in!
  def create
    @item = Item.find(params[:item_id])
    @review = @item.reviews.build(review_params)
    @review.user = current_user
    if @review.save
      redirect_to @item, notice: 'Review was successfully created.'
    else
      render 'items/show'
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
