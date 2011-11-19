class AuthenticationsController < ApplicationController
  # session[:omniauth] = omniauth
  
  def failure
    redirect_to settings_path, :notice => "Something went wrong this website was not enabled."    
  end
  
  def create
    auth = request.env["omniauth.auth"]
    platform_id = Platform.find_by_name(auth["provider"]).id
    
    current_user.authentications.find_or_create_by_platform_id_and_uid(
      :platform_id  => platform_id, 
      :uid => auth["uid"],
      :token => auth["credentials"]["token"],
      :secret => auth["credentials"]["secret"])
    
    if platform_id == 2   # Facebook: Check to see if user has pages
      if current_user.facebook.accounts.length > 0
        redirect_to settings_path(:display_pages => "true"), :notice => "#{display} is now enabled."
      end
    else  
      display = Platform.find_by_name(auth['provider']).display_name
      redirect_to settings_path, :notice => "#{display} is now enabled."
    end
  end

  def destroy
    platform = Platform.find(params[:id])
    
    # current_user.authentications.find_or_create_by_platform_id_and_business_id(:platform_id  => platform.id, :business_id => current_user.business.id).destroy
    redirect_to settings_path, :notice => "#{platform.display_name} is now disabled"
  end
end
