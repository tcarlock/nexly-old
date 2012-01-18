require 'facebook_wall_worker'
require 'facebook_fanpage_worker'
require 'twitter_worker'
require 'linked_in_worker'

class PostFactory  
  def initialize current_user, root_domain, resource
    @current_user = current_user
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
    # Save tracking link
    @post.generate_links(platform)
    TrackingLink.find_or_create_by_in_url(:in_url => @post.shortened_link, :out_url => @post.full_link)

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

          worker.token = auth.token
          worker.message = @post.message
          worker.link = @post.shortened_link
          worker.name = @post.name
          worker.queue
        end
      when :twitter
        # Process for 140 char count limit taking into account shortened link length
        short_link_len = 20
        sep_text = "..."
        max_msg_len = (140 - short_link_len - (sep_text.length + 1))
        
        # Return message shortened by length of Twitter's converted links (19 chars) to fit 140 char limitation
        if @post.message.length > max_msg_len
          short_split = @post.message[0..max_msg_len].split()
          message = short_split[0, short_split.length - 1].join(' ') + sep_text
        end

        worker = TwitterWorker.new
        worker.token = auth.token
        worker.secret = auth.secret
        worker.message = message + " " + @post.shortened_link
        worker.queue
      when :linked_in
        worker = LinkedInWorker.new
        worker.token = auth.token
        worker.secret = auth.secret
        worker.message = @post.message + " " + @post.shortened_link
        worker.queue
    end
  end

  private

  def get_auth platform_name
    platform_id = Platform.find_by_name(platform_name).id
    @current_user.authentications.find_by_platform_id(platform_id)
  end
end