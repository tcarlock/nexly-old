class ReviewResponsesController < ApplicationController
  def new
    @review = Review.find(params[:review_id])
    @response = @review.build_review_response()
  end

  def create
    
  end
end
