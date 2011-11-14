class TrafficDetails
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
      when TrafficDetails.filter_types[:link_type]
        filter = :link_type_id
      when TrafficDetails.filter_types[:platform]
        filter = :platform_id
    end

	  self.page_views = self.page_views.where(filter => filter_parameter)
	  self
  end
  
  def get_time_series frequency    
    self.page_views.group_by{ |u| u.created_at.beginning_of_month }.map {|date_str, g| [date_str.to_i * 1000, g.count]}
  end
  
  private
  
  def reset_dataset
    self.page_views = Business.find(@business_id).page_views.where("created_at >= ? AND created_at < ?", self.start_date, self.end_date).order(:created_at)
	end
end