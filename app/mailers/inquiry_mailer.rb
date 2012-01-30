class InquiryMailer < ActionMailer::Base
  default :from => "\"Nexly Admin\" <admin@nexly.com>"
  
  def new_inquiry_alert inquiry
    @inquiry = inquiry
    @redir_url = business_active_inquiries_url(@inquiry.business)

    mail(:to => inquiry.business.users.first.email, :subject => "A new inquiry has been submitted...")
  end
  
  def inquiry_sent_alert inquiry
    @inquiry = inquiry

    mail(:to => inquiry.email, :subject => "Your inquiry for #{inquiry.business.name}...")
  end
end
