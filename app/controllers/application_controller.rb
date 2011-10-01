class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  
  protect_from_forgery
  
  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      if current_user.profile.nil?
        new_user_profile
      else
        if current_user.businesses.first.nil?
          :root
        else
          current_user.businesses.first
        end
      end
    else
      super
    end
  end
end
