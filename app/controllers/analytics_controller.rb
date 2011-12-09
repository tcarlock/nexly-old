class AnalyticsController < ApplicationController
  def index
      business = Business.find(params[:business_id])
      @traffic = business.traffic_browser([business.created_at, 12.months.ago].max, DateTime.current)

      # @total_series = @traffic.get_time_series(TrafficDetails.time_series[:monthly])
      @review_series = @traffic.filter(TrafficDetails.filter_types[:link_type], PageView.page_types[:review]).get_time_series(TrafficDetails.time_series[:monthly])
      @profile_series = @traffic.filter(TrafficDetails.filter_types[:link_type], PageView.page_types[:profile]).get_time_series(TrafficDetails.time_series[:monthly])
  end
end
