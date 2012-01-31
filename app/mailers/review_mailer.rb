class ReviewMailer < ActionMailer::Base
  default :from => "\"Nexly Admin\" <admin@nexly.com>"
  
  def new_review_alert review
    @review = review
    @redir_url = business_approved_reviews_url(@business)

    mail(:to => review.business.users.first.email, :subject => "A new review has been submitted...")
  end
  
  def new_request_alert request
    @request = request
    @sender = request.user.profile

    mail(:to => request.email, :subject => "#{@sender.first_name} #{@sender.last_name} at #{request.business.name} has requested that you submit a review...")
  end
end
