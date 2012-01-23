Feature.delete_all
Platform.delete_all

# ActiveRecord::Base.connection.reset_pk_sequence!('features')
# ActiveRecord::Base.connection.reset_pk_sequence!('platforms')

Feature.create!(
                :title => 'Reviews',
                :details => 'Reviews allows you to easily request and manage client reviews.  It also allows you to distribute those reviews to your various social media pages and your own website',
                :price => 25,
                :icon => "reviews.png",
                :display_order => 1,
                :lookup_key => "reviews",
                :is_public => true)

Feature.create!(
                :title => 'News',
                :details => 'The news feature allows you to easily publish updates to your clients and prospects.  Plus, all updates can go straight to your social-media pages and your website.',
                :price => 25,
                :icon => "news.png",
                :display_order => 2,
                :lookup_key => "news",
                :is_public => false)

Feature.create!(
                :title => 'Resources',
                :details => 'Resources allows you to easily publish and manage learning materials and information such as articles, white papers, links, etc.',
                :price => 35,
                :icon => "resources.png",
                :display_order => 3,
                :lookup_key => "resources",
                :is_public => false)

Platform.create!(:name => 'linked_in', :display_name => 'LinkedIn', :icon => 'linkedin.png', :display_order => 1)
Platform.create!(:name => 'facebook', :display_name => 'Facebook', :icon => 'facebook.png', :display_order => 2)
Platform.create!(:name => 'twitter', :display_name => 'Twitter', :icon => 'twitter.png', :display_order => 3)
Platform.create!(:name => 'google', :display_name => 'Google+', :icon => 'google_plus.png', :is_available => false, :display_order => 4)
Platform.create!(:name => 'google', :display_name => 'Google Places', :icon => 'google.png', :is_available => false, :display_order => 5)