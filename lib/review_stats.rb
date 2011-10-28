class ReviewStats
  def initialize business_id
    @business = Business.find(business_id)
  end
  
  def total_review_count
    @business.reviews.count
  end
  
  def pending_review_count
    @business.pending_reviews.count
  end
  
  def approved_review_count
    @business.approved_reviews.count
  end
  
  def rejected_review_count
    @business.rejected_reviews.count
  end
  
  def pending_request_count
    @business.pending_review_requests.count
  end
  
  def average_rating
    Review.average(:rating, :conditions => ["business_id = ?", @business.id])
  end
  
  def min_rating
  end
  
  def max_rating
  end
  
  def submission_rate
    if @business.review_requests.count == 0
      0.0 / 0.0
    else
      (@business.review_requests.count - @business.active_review_requests) / @business.review_requests.count
    end
  end
end