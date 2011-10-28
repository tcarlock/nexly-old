class TrafficStats
  attr_accessor :current_data_set, :from_date, :to_date
  
  # Get traffic data by timeframe
  
	def initialize business_id, from = 365.days.ago, to = DateTime.current
		self.from_date = from
		self.to_date = to
		
		@business = Business.find(business_id)
		self.current_data_set = @business.page_views
	end

  def page_views
    if self.current_data_set.empty?
      0
    else
      self.current_data_set.count
    end
  end
	
	def views_by_link_type link_type
		self.current_data_set.where(:link_type_id => link_type).count
	end
	
	def views_by_platform platform_id
		self.current_data_set.where(:platform_id => platform_id).count
	end
	
	protected
	
	def get_month_dataset
  end
  
	def get_quarter_dataset
  end
  
	def get_annual_dataset
  end
end