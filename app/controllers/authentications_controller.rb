class AuthenticationsController < ApplicationController
  # session[:omniauth] = omniauth
  
  def failure
    # display = Platform.find_by_name(request.env["omniauth.auth"]["provider"]).display_name
    redirect_to settings_business_path(current_user.business), :notice => "This website was not enabled."    
  end
  
  def create
    auth = request.env["omniauth.auth"]
    current_user.authentications.find_or_create_by_platform_id_and_uid(
      :platform_id  => Platform.find_by_name(auth["provider"]).id, 
      :uid => auth["uid"],
      :token => auth["credentials"]["token"],
      :secret => auth["credentials"]["secret"])
    
    display = Platform.find_by_name(auth['provider']).display_name
    redirect_to settings_business_path(current_user.business), :notice => "#{display} is now enabled."
  end

  def destroy
    current_user.authentications.find_or_create_by_platform_id_and_uid(:platform_id  => platform_id, :uid => auth["uid"]).destroy!
  end
end
