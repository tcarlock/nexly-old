module BusinessesHelper
  
  def display_logo(business, avatarSize = :small)
    <<-block
      <div class="avatar">#{image_tag business.avatar.url(avatarSize), :class => 'img-corners'}</div>
    block
  end
  
  def display_address(business)
    <<-block
      <div>#{business.address_1} #{business.address_2}</div>
      <div>#{business.city}, #{business.state} #{business.zip_code}</div>
    block
  end
end
