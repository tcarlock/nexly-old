class RecommendationMailer < ActionMailer::Base
  def new_recommendation_alert recommendation, redir_url
    @rec = recommendation
    @redir_url = redir_url
    
    mail(:from => "admin@nexly.com", :to => recommendation.email, :subject => "#{recommendation.name} has shared a recommendation with you...")
  end
end
