class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      current_user.businesses.first
    else
      super
    end
  end
  
  private 

  def authenticate
    deny_access unless signed_in?
  end
end
