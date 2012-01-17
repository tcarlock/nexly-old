class TrafficMeta
  attr_accessor :page_views, :start_date, :end_date
  
  def self.filter_types
    {:link_type  => 1, :platform => 2}
  end
  
  def self.time_series
    {:monthly  => 1, :weekly => 2, :daily => 3}
  end
  
	def initialize business_id, start_date, end_date
	  @business_id = business_id
		self.start_date = start_date
		self.end_date = end_date
		
		reset_dataset
	end
  
  def filter filter_type, filter_parameter = nil
    reset_dataset
    
    case filter_type
      when TrafficMeta.filter_types[:link_type]
        filter = :link_type_id
      when TrafficMeta.filter_types[:platform]
        filter = :platform_id
    end

	  self.page_views = self.page_views.where(filter => filter_parameter)
	  self
  end
  
  def get_time_series frequency, include_labels = true
    if include_labels
      self.page_views.group_by{ |u| u.created_at.beginning_of_month }.map {|date_str, g| [date_str.to_i * 1000, g.count]}
    else
      self.page_views.group_by{ |u| u.created_at.beginning_of_month }.map {|date_str, g| g.count}
    end
  end
  
  def get_percentage_change frequency 
    time_series, change_array = get_time_series(frequency), []

    # Get difference from month to month and calculate and calculate an average
    change_array = time_series.each_cons(2).map{|a,b| [b[0], (b[1].to_f - a[1].to_f) / a[1].to_f]}
    change_array.inject(0.0){|sum, arr_item| sum += arr_item[1]} / change_array.length
  end
  
  def get_traffic_allocation allocation_type
    total_page_views = self.page_views.count

    if total_page_views > 0
      case allocation_type
        when TrafficMeta.filter_types[:link_type]
          self.page_views.group_by{ |u| u.link_type_id }.map {|link_type_id, g| [link_type_id, g.count.to_f/total_page_views.to_f*100]}
        when TrafficMeta.filter_types[:platform]
          self.page_views.group_by{ |u| u.platform_id }.map {|platform_id, g| [g.first.platform.display_name, g.count.to_f/total_page_views.to_f*100]}
      end
    end
  end

  private
  
  def reset_dataset
    self.page_views = Business.find(@business_id).page_views.where("created_at >= ? AND created_at < ?", self.start_date, self.end_date).order(:created_at)
	end
end