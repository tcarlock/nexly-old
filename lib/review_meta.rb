class ReviewMeta
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
  
  def total_request_count
    @business.review_requests.count
  end
  
  def pending_request_count
    @business.pending_review_requests.count
  end
    
  def request_response_rate
    if @business.review_requests.count == 0
      0.0 / 0.0
    else
      (@business.review_requests.count - @business.pending_review_requests.count).to_f / @business.review_requests.count.to_f
    end
  end
  
  def average_rating
    Review.average(:rating, :conditions => ["business_id = ?", @business.id])
  end
  
  
  def get_rating_distribution include_labels = true
    if include_labels
      @business.reviews.order("rating desc").group_by{ |r| r.rating }.map {|rating, g| [rating, g.count]}
    else
      @business.reviews.order("rating desc").group_by{ |r| r.rating }.map {|rating, g| g.count}
    end
  end
end