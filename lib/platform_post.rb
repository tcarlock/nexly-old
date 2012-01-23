class PlatformPost
  attr_accessor :message, :link, :name
  
  def self.traffic_channel_types
    {:email  => 1, :web => 2}
  end

  def self.resource_types
    {:recommendation  => 1, :review => 2, :news => 3}
  end

  def initialize business, root_domain, resource
    @business = business
    @root = root_domain
    @resource = resource
    @redir_url = @business.website
    
    # Create post contents and tracking link
    if @resource.class == Review
      @message = "A new review has been posted for #{@business.name}: " + resource.details
      @name = "View our website"
    elsif @resource.class == NewsPost
      @message = "#{@business.name} has posted a news update: " + resource.content
      @name = "View our website"
    end
  end

  def generate_link channel, platform
    if channel == :web
      platform_id = Platform.find_by_name(platform.to_s).id
    else
      platform_id = 0
    end

  	if @resource.class == Recommendation
      @link = create_redir_link(@redir_url, @business.id, PlatformPost.resource_types[:recommendation], @resource.id, channel, platform_id)
    elsif @resource.class == Review
      @link = create_redir_link(@redir_url, @business.id, PlatformPost.resource_types[:review], @resource.id, channel, platform_id)
    elsif @resource.class == NewsPost
      @link = create_redir_link(@redir_url, @business.id, PlatformPost.resource_types[:news], @resource.id, channel, platform_id)
    end
  end

  private

  def create_redir_link url, business_id, resource_type, resource_reference_id, channel_type, platform_id
    "#{@root}/redir/?url=#{url}&bizId=#{business_id.to_s}&resourceType=#{resource_type.to_s}&resourceId=#{resource_reference_id.to_s}&channel=#{PlatformPost.traffic_channel_types[channel_type].to_s}" << (platform_id > 0 ? "&platformId=#{platform_id}" : "")
  end
end