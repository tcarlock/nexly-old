class RecommendationMailer < ActionMailer::Base
  def new_recommendation_alert recommendation, redir_url
    @rec = recommendation
    @redir_url = redir_url
    
    mail(:from => "\"Nexly Admin\" <admin@nexly.com>", :to => recommendation.email, :subject => "#{recommendation.name} has recommended a business for you...")
  end
end
