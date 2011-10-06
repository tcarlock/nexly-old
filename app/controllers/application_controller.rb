class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  
  protect_from_forgery
  
  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      if current_user.profile.created_at == current_user.profile.updated_at
        redirect_to edit_user_profile_path(current_user.profile)
      else
        if current_user.businesses.first.nil?
          redirect_to new_business_path()
        else
          current_user.businesses.first
        end
      end
    else
      super
    end
  end
end
