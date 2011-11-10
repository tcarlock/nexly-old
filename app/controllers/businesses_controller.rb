class BusinessesController < ApplicationController
  before_filter :get_business, :only => [:show, :edit, :update, :edit_capabilities, :settings]
  before_filter :set_menu_visibility, :only => [:new, :create]
  
  def index
    @businesses = Business.search params[:q]
  end

  def show
  end

  def new
    @business = current_user.businesses.build()
  end
  
  def edit
  end

  def create
    @business = current_user.businesses.create(params[:business])
    
    if @business.save
      respond_to do |format|
        format.html {
          redirect_to(@business, :notice => 'Your business profile has been saved')
        }
        format.js
      end
    else
      render :action => "new"
    end
  end
  
  def update
    if params[:business][:update_tags]
      tags = params[:business][:capabilities_string].split(",")   
      @business.capability_list = tags
    end

    @business.update_attributes(params[:business])
    @business.save

    redirect_to(@business, :notice => 'Your business profile has been updated')
  end
  
  def edit_capabilities
  end
  
  def settings
    @business = Business.find(params[:id])
    @apps = Application.where(:is_public => true)
    @enabled_apps = @business.applications
    @platforms = Platform.where(:is_available => true).order(:display_order)
    @enabled_platforms = current_user.authentications
    @toolbar_bootstrap_script = render_to_string :partial => 'plugins/toolbar_bootstrap_script', :locals => { :network => @business.api_token, :root => DOMAIN_NAMES[Rails.env] }
    @toolbar_init_script = render_to_string :partial => 'plugins/toolbar_init_script'
    @platform_suggestion = PlatformSuggestion.new
  end
  
  private

  def get_business
    if params[:id] != nil
      @business = Business.find(params[:id])
      @reviews = @business.reviews.order('created_at DESC').paginate(:page => params[:page])
    end
  end
end
