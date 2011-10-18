class TrafficStats
	def initialize id
		@business = Business.find(id)
	end

	def incoming_traffic
		@business.link_clicks.count
	end
	
	def traffic_by_link_type link_type
		@business.link_clicks.where(:link_type_id => link_type).count
	end
	
	def traffic_by_domain domain
		@business.link_clicks.where(:referrer_domain => domain).count
	end
	
	protected
	
	def get_month_dataset
  end
  
	def get_quarter_dataset
  end
  
	def get_annual_dataset
  end
end