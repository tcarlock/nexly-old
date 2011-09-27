class ReviewResponsesController < ApplicationController
  def new
    @review = Review.find(params[:id])
    @response = @review.response_build()
  end

  def create
  end
end
