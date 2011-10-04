module UserProfileHelper
  
  def display_avatar(user, avatarSize = :small)
    <<-block
      <div class="avatar">#{image_tag user.profile.avatar.url(avatarSize), :class => 'img-corners'}</div>
    block
  end
  
  def display_details(user, show_admin_bio, long_form = false)
    if show_admin_bio
      @bio = show_admin(user.profile.biography)
    else
      @bio = user.profile.biography
    end
      
    @output = '<ul class="profile-details">'
     
    @output << 
      <<-block
        <li class="user-name"> #{ link_to(user.profile.user.display_name << ' (' << user.profile.screen_name << ')', profile_path(user.profile)) } </li>
        <li class="location">   <span class="label">  Location:   </span>  #{user.location }       </li>
        <li class="biography"><span>  <span class="label">  Biography:  </span></span>  #{@bio} </li>
     block

     if(long_form)
       @output <<
         <<-block
           <li class="facebook">   <span class="label">  Facebook:   </span>  #{'http://facebook.com/' + user.profile.facebook }   </li>
           <li class="twitter">    <span class="label">  Twitter:    </span>  #{user.profile.twitter}     </li>
           <li class="google">     <span class="label">  Google Plus:</span>  #{user.profile.google_plus} </li>
           <li class="linked-in">  <span class="label">  LinkedIn:   </span>  #{user.profile.linked_in}   </li>
           <li class="address-1">  <span class="label">  Address 1:  </span>  #{user.profile.address_1}   </li>
           <li class="address-2">  <span class="label">  Address 2:  </span>  #{user.profile.address_2}   </li>
           <li class="zip-code">   <span class="label">  Zip Code:   </span>  #{user.profile.zip_code }   </li>
        block
      end
      
    @output << '</ul>'
  end
  
  def display_interests(user)
    out = "<ul class='standard-list profile-item-list'>"
    
    user.profile.interests.each do |tag|
      out << "<li>#{link_to tag.name, search_profile_index_path(:tag => tag.id)}</li>"
    end
    out << "</ul>"
  end  
end
