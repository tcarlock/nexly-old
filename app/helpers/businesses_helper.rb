module BusinessesHelper
  
  def display_logo(business, avatarSize = :small)
    <<-block
      <div class="avatar">#{image_tag business.avatar.url(avatarSize), :class => 'img-corners'}</div>
    block
  end
end
