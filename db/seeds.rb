Application.create!(
                :title => 'Reviews',
                :details => 'Reviews allows you to easily request and manage client reviews.  It also allows you to distribute those reviews to your various social media pages and your own website',
                :price => 24.99,
                :is_public => true)

Application.create!(
                :title => 'Resources',
                :details => 'Resources allows you to easily publish and manage learning materials and information such as articles, white papers, links, etc.',
                :price => 34.99,
                :is_public => false)

Platform.delete_all
Platform.create!(:name => 'linked_in', :display_name => 'LinkedIn', :icon => 'linkedin.png', :display_order => 1)
Platform.create!(:name => 'facebook', :display_name => 'Facebook', :icon => 'facebook.png', :display_order => 2)
Platform.create!(:name => 'twitter', :display_name => 'Twitter', :icon => 'twitter.png', :display_order => 3)
Platform.create!(:name => 'google', :display_name => 'Google Places', :icon => 'google.png', :display_order => 4)
Platform.create!(:name => 'google', :display_name => 'Google+', :icon => 'google_plus.png', :is_available => false, :display_order => 5)