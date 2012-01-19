class AnalyticsController < ApplicationController
	skip_before_filter :verify_authenticity_token, :only => :track_link
	skip_before_filter :authenticate_user!, :only => :track_link

  def index
    business = Business.find(params[:business_id])
    @traffic_meta = business.traffic_meta([business.created_at, 12.months.ago].max, DateTime.current)

    @total_series = @traffic_meta.get_time_series(TrafficMeta.time_series[:monthly])
    @review_series = @traffic_meta.filter(TrafficMeta.filter_types[:link_type], PageView.page_types[:review]).get_time_series(TrafficMeta.time_series[:monthly])
    @profile_series = @traffic_meta.filter(TrafficMeta.filter_types[:link_type], PageView.page_types[:profile]).get_time_series(TrafficMeta.time_series[:monthly])
  end

  def track_link
		TrackingLink.find_or_create_by_in_url(:in_url => params[:in_url], :out_url => params[:out_url])

		render :nothing => true
  end
end
