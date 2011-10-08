class RecommendationMailer < ActionMailer::Base
  def new_recommendation recommendation
    @rec = recommendation
    
    mail(:from => "admin@nexly.com", :to => recommendation.email, :subject => "#{recommendation.name} has a recommendation for you...")
  end
end
