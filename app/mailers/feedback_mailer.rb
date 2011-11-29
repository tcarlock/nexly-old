class FeedbackMailer < ActionMailer::Base
  default :from => "admin@nexly.com", :to => "tcarlock+admin@nexly.com"
  
  def new_platform_suggestion_alert suggestion
    @suggestion = suggestion

    mail(:subject => "A new platform has been suggested...")
  end
  
  def new_feedback_alert suggestion
    @suggestion = suggestion

    mail(:subject => "A new suggestion has been submitted...")
  end
end
