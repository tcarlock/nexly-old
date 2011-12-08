class PlatformPagesController < ApplicationController
  def index
    @platform_id = params[:platform_id].to_i
    @active_pages = current_user.business.active_platforms.find(@platform_id).platform_pages
    
    platform_name = Platform.find(@platform_id).name

    case platform_name
      when "facebook"
        @accounts = current_user.facebook.accounts
    end

    render :layout => false
  end
  
  def toggle_publishing
    platform = Platform.find(params[:platform_id])
    page = current_user.business.active_platforms.find(params[:platform_id]).platform_pages.find_or_initialize_by_external_id(params[:id])

    if page.persisted?   # Record already existed; delete
      page.destroy
    else
      page.save
    end
    
    render :nothing => true
  end
end
