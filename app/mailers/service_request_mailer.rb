class ServiceRequestMailer < ActionMailer::Base
  default :from => "admin@nexly.com", :to => "timothy.carlock@gmail.com"

  def new_request_alert request
    @request = request

    mail(:subject => "New service request received")
  end
end
