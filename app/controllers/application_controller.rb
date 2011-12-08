class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  before_filter :set_menu_visibility
  before_filter :check_for_biz    # Make sure user has created a biz profile
    
  protect_from_forgery
  
  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      if current_user.business.nil?
        new_business_path
      else
        dashboard_path
      end
    else
      super
    end
  end
  
  def set_menu_visibility
    @hide_menu = (Rails.env == 'production') && (signed_in? && (current_user.profile.nil? || current_user.business.nil?))
  end

  def check_for_biz
    unless devise_controller?
      if signed_in? && current_user.business.nil?
        redirect_to new_business_path
      end
    end
  end
end
