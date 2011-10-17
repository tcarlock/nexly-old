class AuthenticationsController < ApplicationController
  # session[:omniauth] = omniauth
  
  def index
  end

  def create
    auth = request.env["omniauth.auth"]
    platform_id = Platform.find_by_name(auth["provider"]).id
    current_user.authentications.find_or_create_by_platform_id_and_uid(
      :platform_id  => platform_id, 
      :uid => auth["uid"],
      :token => auth["credentials"]["token"],
      :secret => auth["credentials"]["secret"])
    
    redirect_to settings_business_path(current_user.businesses.first), :notice => "#{auth['provider']} is now enabled."
  end

  def destroy
  end
end
