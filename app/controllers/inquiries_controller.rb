class InquiriesController < ApplicationController
	skip_before_filter :authenticate_user!, :only => [:new, :create]
  before_filter :get_business, :only => [:active_inquiries, :archived_inquiries, :new, :create]
  
  caches_action :new
  
  def active_inquiries
    get_inquries :active
  end
      
  def archived_inquiries
    get_inquries :archived
  end
  
  def new
    @view = params[:v] || 'standard'

    if @view == 'toolbar'
      layout = 'plugin_canvas'
    else
      layout = true
    end

    @inquiry = @business.inquiries.build()

    render :layout => layout 
  end

  def create
    @inquiry = @business.inquiries.create(params[:inquiry])
    
    if @inquiry.valid?
      InquiryMailer.new_inquiry_alert(@inquiry).deliver
      InquiryMailer.inquiry_sent_alert(@inquiry).deliver
    
      render :nothing => true
    else
      render :new
    end
  end

  def archive
  	Inquiry.find(params[:id]).update_attributes(:is_archived => true)
  	    
    respond_to do |format|
      format.js
    end
  end
  
  private 
  
  def get_business
    if params[:business_id] != nil
      @business = Business.find(params[:business_id])
    end
  end
  
  def get_inquries status
    case status
      when :active
        @inquiries = @business.active_inquiries
        @header = 'Active Inquiries'
      when :archived
        @inquiries = @business.archived_inquiries
        @header = 'Archived Inquiries'
    end

    @view = status.to_s
    @inquiries = @inquiries.order('created_at DESC').paginate(:page => params[:page])

    render 'inquiries/index'
  end
end