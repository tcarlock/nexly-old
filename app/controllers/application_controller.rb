class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  before_filter :set_menu_visibility
    
  protect_from_forgery
  
  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      if current_user.businesses.first.nil?
        new_business_path
      else
        dashboard_path
      end
    else
      super
    end
  end
  
  def set_menu_visibility
    @hide_menu = true if (signed_in? && (current_user.profile.nil? || current_user.businesses.first.nil?))
  end
end
