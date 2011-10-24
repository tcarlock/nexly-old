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
                
Platform.create!(:name => "facebook")
Platform.create!(:name => "linkedin")
Platform.create!(:name => "twitter")
Platform.create!(:name => "google+")
Platform.create!(:name => "google places")