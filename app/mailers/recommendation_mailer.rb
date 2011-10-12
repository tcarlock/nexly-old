class RecommendationMailer < ActionMailer::Base
  def new_recommendation_alert recommendation
    @rec = recommendation
    
    mail(:from => "admin@nexly.com", :to => recommendation.email, :subject => "#{recommendation.name} has shared a recommendation with you...")
  end
end
