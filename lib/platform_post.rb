class PlatformPost
  attr_accessor :full_link, :shortened_link, :message, :name
  
  def initialize business, root_domain, resource
    @business = business
    @root = root_domain
    @resource = resource
    @redir_url = @business.website
    
    # Create post contents and tracking link
    if @resource.class == Review
      self.message = "A new review has been posted for #{@business.name}: " + resource.details
      self.name = "View our website"
    elsif @resource.class == NewsPost
      self.message = "#{@business.name} has posted a news update: " + resource.content
      self.name = "View our website"
    end
  end

  def generate_links platform
  	pId = Platform.find_by_name(platform.to_s).id

  	if @resource.class == Review
      self.full_link = create_redir_link(@redir_url, @business.id, @resource.id, PageView.page_types[:review], pId)
      self.shortened_link = shorten_with_bitly(CGI::escape(self.full_link))
    elsif @resource.class == NewsPost
      self.full_link = create_redir_link(@redir_url, @business.id, @resource.id, PageView.page_types[:news], pId)
      self.shortened_link = shorten_with_bitly(CGI::escape(self.full_link))
    end
  end

  private

  def create_redir_link url, business_id, reference_id, link_type_id, platform_id
    "#{@root}/redir/?url=#{url}&bId=#{business_id.to_s}&rId=#{reference_id.to_s}&tId=#{link_type_id.to_s}&pId=#{platform_id}"
  end
  
  def shorten_with_bitly url
    user = "nexly"
    apikey = "R_5ce84a66ab4a18fd093901d718c27545"
    bitly_url = "http://api.bitly.com/v3/shorten/?login=#{user}&apiKey=#{apikey}&longUrl=#{url}&format=json"
    
    buffer = open(bitly_url, "UserAgent" => "Ruby-ExpandLink").read
    JSON.parse(buffer)['data']['url']
  end

end