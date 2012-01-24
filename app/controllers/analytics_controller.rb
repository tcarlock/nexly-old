class AnalyticsController < ApplicationController
	skip_before_filter :verify_authenticity_token, :only => :track_link
	skip_before_filter :authenticate_user!, :only => :track_link

  def index
    if !current_user.admin
      render :text => "You don't have permission to view this page", :layout => true
    else
      sort_field = params[:sortField] || 'user_profiles.last_name'
      
      if params[:sortDir].nil?
        @sort_dir = 'asc'
      else
        @sort_dir = (params[:sortDir].to_s == 'asc' ? 'desc' : 'asc')
      end

      @users = User.paginate(:page => params[:page], :per_page => 15).find(:all, :include => [:profile, :business], :order => sort_field << ' ' << @sort_dir)
    end
  end

  def track_link
		TrackingLink.find_or_create_by_in_url(:in_url => params[:in_url], :out_url => params[:out_url])

		render :nothing => true
  end
end
