class PostFactory
  attr_accessor :full_link, :short_link
  
  def initialize current_user
    @current_user = current_user
    @business = @current_user.business
  end
  
  def post_to_facebook! resource
    if @current_user.facebook.nil?
      return false
    else
      return generate_post(resource, :facebook)
    end
  end
  
  def post_to_linkedin! resource
    if @current_user.linkedin.nil?
      return false
    else
      return generate_post(resource, :linked_in)
    end
  end
  
  def post_to_twitter! resource
    if @current_user.twitter.nil?
      return false
    else
      return generate_post(resource, :twitter)
    end
  end
  
  private
  
  def generate_post resource, format
    pId = Platform.find_by_name(format.to_s).id
    
    if resource.class == Review
      self.full_link = create_redir_link(@business.website, @business.id, resource.id, PageView.types[:review], pId)
      self.short_link = shorten_with_bitly(CGI::escape(self.full_link))
      message = "A new review has been posted for #{@business.name}: " + resource.details
      name = "View our website"
    end

    case format
      when :facebook
        return @current_user.facebook.feed!(
          :message => message,
          :link => self.short_link, 
          :name => name
        )
      when :twitter
        # Process for 140 char count limit taking into account shortened link length
        short_link_len = 13
        sep_text = "... "
        max_msg_len = (140 - short_link_len - sep_text.length)
        
        # Return message shortened by length of Twitter's converted links (19 chars) to fit 140 char limitation
        if message.length > max_msg_len
          short_split = message[0..max_msg_len].split()
          message = short_split[0, short_split.length - 1].join(' ') + sep_text
        end
        
        return @current_user.twitter.update(message + self.short_link)
      when :linked_in
        return @current_user.linkedin.add_share(:comment => message + self.short_link)
    end
  end
  
  def create_redir_link(url, business_id, reference_id, link_type_id, platform_id)
    root = (ENV['RAILS_ENV'] == 'production' ? DOMAIN_NAME : "http://127.0.0.1:3000")
    "#{root}/redir/?url=#{url}&bId=#{business_id.to_s}&rId=#{reference_id.to_s}&tId=#{link_type_id.to_s}&pId=#{platform_id}"
  end
  
  def shorten_with_bitly(url)
    user = "nexly"
    apikey = "R_5ce84a66ab4a18fd093901d718c27545"
    bitly_url = "http://api.bitly.com/v3/shorten/?login=#{user}&apiKey=#{apikey}&longUrl=#{url}&format=json"
    
    buffer = open(bitly_url, "UserAgent" => "Ruby-ExpandLink").read
    JSON.parse(buffer)['data']['url']
  end
end