class TrafficStats
	def initialize id
		@business = Business.find(id)
	end

  def page_views
    page_views = @business.page_views
    if page_views.empty?
      0
    else
      @business.page_views.count
    end
  end
	
	def views_by_link_type link_type
		@business.page_views.where(:link_type_id => link_type).count
	end
	
	def views_by_platform platform_id
		@business.page_views.where(:platform_id => platform_id).count
	end
	
	protected
	
	def get_month_dataset
  end
  
	def get_quarter_dataset
  end
  
	def get_annual_dataset
  end
end