class BusinessesController < ApplicationController
  before_filter :get_business, :only => [:show, :edit, :update, :edit_capabilities]
  
  def index
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
  
  def settings
    
  end
  
  def edit_capabilities
  end

  private

  def get_business
    if params[:id] != nil
      @business = Business.find(params[:id])
      @reviews = @business.reviews.order('created_at DESC').paginate(:page => params[:page])
    end
  end
end
