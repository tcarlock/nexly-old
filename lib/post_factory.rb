require 'iron_worker'

class PostFactory  
  def initialize current_user, root_domain, resource
    @current_user = current_user
    @root_domain = root_domain
    @post = PlatformPost.new(@current_user.business, root_domain, resource)
  end
  
  def post_to_all 
    self.post_to_facebook
    self.post_to_linkedin
    self.post_to_twitter
  end

  def post_to_facebook
    return generate_post(:facebook)
  end
  
  def post_to_linkedin
    return generate_post(:linked_in)
  end
  
  def post_to_twitter
    return generate_post(:twitter)
  end
    
  private
  
  def generate_post platform
    # Generate link for posts
    @post.generate_link(:social, platform)

    # Create/queue worker job
    auth = get_auth(platform.to_s)

    case platform
      when :facebook
        # Get settings to determine where user wants to post (e.g., profile wall, fanpage, etc.)
        platform_id = Platform.find_by_name("facebook").id
        active_pages = @current_user.business.active_platforms.find(platform_id).platform_pages
        
        active_pages.each do |p|
          if p.external_id == "0"   # Post to profile wall
            worker = FacebookWallWorker.new
          else   # Post to fanpage wall
            worker = FacebookFanpageWorker.new
            worker.page_id = p.external_id
          end 

          worker.oauth_token = auth.token
          worker.bitly_api_key = 'R_5ce84a66ab4a18fd093901d718c27545'
          worker.link_tracking_url = @root_domain + '/analytics/track_link'
          worker.name = @post.name
          worker.message = @post.message
          worker.link = @post.link
          worker.queue
        end
      when :twitter
        worker = TwitterWorker.new
        worker.oauth_token = auth.token
        worker.oauth_secret = 'xqYOCHuzwkD3o3JVYis9zyy9qXMQUP8NvKOo0leiXIA'
        worker.consumer_key = 'HjzVzzin2zCogq8tNezeA'
        worker.consumer_secret = 'oiD9D0lJROgl6giJ3UofU1iRZEGCIHOBXD8t9VVB01o'
        worker.link_tracking_url = @root_domain + '/analytics/track_link'
        worker.bitly_api_key = 'R_5ce84a66ab4a18fd093901d718c27545'
        worker.message = @post.message
        worker.link = @post.link
        worker.queue
      when :linked_in
        worker = LinkedInWorker.new
        worker.oauth_token = auth.token
        worker.oauth_secret = auth.secret
        worker.consumer_key = '694wVPqtdE2lQmrRRJ2YG-uxoVA-f1E6Cb6cPUdxe2xUMcwuaq4D0wgmcdwAoucg'
        worker.consumer_secret = '0tY-2DGwi0w1MbtitnV1I9PIjdOUqyDoVSNxWspucm0ZfziRJmAxHB_Dqwi1m_zM'
        worker.link_tracking_url = @root_domain + '/analytics/track_link'
        worker.bitly_api_key = 'R_5ce84a66ab4a18fd093901d718c27545'
        worker.message = @post.message
        worker.link = @post.link
        worker.queue
    end
  end

  private

  def get_auth platform_name
    platform_id = Platform.find_by_name(platform_name).id
    @current_user.authentications.find_by_platform_id(platform_id)
  end
end