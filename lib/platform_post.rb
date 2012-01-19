class PlatformPost
  attr_accessor :message, :link, :name
  
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

  def generate_link platform
  	pId = Platform.find_by_name(platform.to_s).id

  	if @resource.class == Review
      @link = create_redir_link(@redir_url, @business.id, @resource.id, PageView.page_types[:review], pId)
    elsif @resource.class == NewsPost
      @link = create_redir_link(@redir_url, @business.id, @resource.id, PageView.page_types[:news], pId)
    end
  end

  private

  def create_redir_link url, business_id, reference_id, link_type_id, platform_id
    "#{@root}/redir/?url=#{url}&bId=#{business_id.to_s}&rId=#{reference_id.to_s}&tId=#{link_type_id.to_s}&pId=#{platform_id}"
  end
end