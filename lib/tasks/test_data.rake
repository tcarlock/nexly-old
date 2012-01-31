namespace :app do
  desc <<-DESC
      Drop and re-create development database
    DESC
    
  task :remount_local_database => [:environment] do
    Rake::Task['db:drop'].execute
    Rake::Task['db:create'].execute
    Rake::Task['db:migrate'].execute
    Rake::Task['db:seed'].execute
    Rake::Task['app:load_demo_data'].execute
    # Rake::Task['ts:index'].execute
    #    Rake::Task['ts:start'].execute
  end
  
  desc <<-DESC
      Load testing data.
      Run using the command 'rake app:load_demo_data'
    DESC
      
  task :load_demo_data => [:environment] do
    # Only data not required in production should be here.
    # If it needs to be there in production, it belongs in seeds.rb.
    User.delete_all
    UserProfile.delete_all
    Business.delete_all
    Review.delete_all
    PageView.delete_all
    Recommendation.delete_all
    Inquiry.delete_all
    Authentication.delete_all
    
    Authentication.create!(
      platform_id: 1,
      uid: '3WN1tB6wg0',
      token: '06ed3edb-e795-47b2-a484-b4a13e53f149',
      secret: 'ea4b6c1c-7beb-4c35-8b5d-d4ca8b1ea05d',
      business_id: 1
    )
    
    Authentication.create!(
      platform_id: 2,
      uid: '100003063373098',
      token: 'AAACVmYzueukBAPz0py39PT4emcBAFcYVGqogqpvk8ghZAXZCWj4HruZCndTSMSa7vwNfXd4ygre0g1Ixe0gUSV69wRqIyk2BJjE95lZAKgZDZD',
      secret: nil,
      business_id: 1
    )
    
    Authentication.create!(
      platform_id: 3,
      uid: '392200113',
      token: '392200113-qzGQrLPoj7wkhCCPpwH6VI1GvlvSaCjJa7Wyjwjj',
      secret: 'xqYOCHuzwkD3o3JVYis9zyy9qXMQUP8NvKOo0leiXIA',
      business_id: 1
    )
    
    #Create demo user, business and reviews
    user = User.create!(:email => 'timothy.carlock@gmail.com', :password => 'password', :password_confirmation => 'password', :is_admin => true)
    user.reload
    user.update_attribute :admin, true
    
    profile = UserProfile.create!(
      :user => user,
      :first_name => 'Tim', 
      :last_name => 'Carlock', 
      :facebook => 'tcarlock', 
      :twitter => 'tcarlock', 
      :google_plus => 'tcarlock',
      :linked_in => 'tcarlock',
      :biography => 'I''m the founder and CEO of an internet startup based in San Francisco',
      :city => 'San Francisco',
      :state => 'CA',
      :updated_at => '2011-08-01 20:18:35',
      :created_at => '2011-08-01 20:18:33',
      :avatar_file_name => 'IMG_4634-1.jpg', 
      :avatar_content_type => 'image/jpeg', 
      :avatar_file_size => 3196303,
      :avatar_updated_at => '2011-08-02 20:46:45', 
      :screen_name => 'tcarlock')
      
    profile.avatar = "https://s3.amazonaws.com/nexly_avatar_dev/original/1/IMG_4634-1.jpg"
    profile.save
    
    biz = user.businesses.create!(
      :name => 'BCI Consulting',
      :phone => Faker::PhoneNumber.phone_number,
      :website => 'http://bci.com', 
      :facebook => 'http://facebook.com/bci', 
      :twitter => 'http://twitter.com/bci', 
      :google_plus => 'http://plus.google.com/bci',
      :linked_in => 'http://linkedin.com/bci',
      :biography => 'We provide technology and services to help small businesses find and select service providers',
      :address_1 => '101 South Hanley Rd',
      :address_2 => nil,
      :city => 'St Louis',
      :state => 'MO',
      :zip_code => '63105',
      :avatar_file_name => 'logo.jpg', 
      :avatar_content_type => 'image/jpeg', 
      :avatar_file_size => 3196303, 
      :avatar_updated_at => '2010-08-02 20:46:45',
      :created_at => '2010-08-02 20:46:45')
      
    biz.avatar = "https://s3.amazonaws.com/nexly_avatar_dev/original/1/logo.jpg"
    biz.preferences[:enable_toolbar] = true
    biz.preferences[:tb_show_rec_btn] = true
    biz.preferences[:tb_show_review_btn] = true

    biz.save
    biz.reload
  
    # Create review requests and reviews
    10.times do |n|
      biz.review_requests.create!(
        :email => Faker::Internet.email,
        :message => Faker::Lorem.paragraph,
        :user_id => 1
      )
    end
    
    review = biz.reviews.create!(
      :first_name => 'Sally',
      :last_name => 'Parsons',
      :email => 'sparsons@leftcoast.com', 
      :details => 'BCI team was very responsive; great to work with',
      :rating => 5,
      :is_approved => false,
      :is_rejected => false)
      
    review.update_attributes!(:created_at => DateTime.current + 30)

    review = biz.reviews.create!(
      :first_name => 'David',
      :last_name => 'Hansson',
      :email => 'dhh@37signals.com',
      :details => 'Great experience working with the firm - we saved time and $ by using their services to select a software development firm. Understood our needs quickly. Would use again',
      :rating => 5,
      :is_approved => false,
      :is_rejected => false)
      
    review.update_attributes!(:created_at => DateTime.current + 30)
      
    review = biz.reviews.create!(
      :first_name => 'Jennifer',
      :last_name => 'Roth',
      :email => 'j.roth@shorts.com', 
      :details => 'We really enjoyed working with them and found their work to be incredible.  The people were easy to work with as well.',
      :rating => 4,
      :is_approved => false,
      :is_rejected => false)
      
    review.update_attributes!(:created_at => DateTime.current + 30)
    
    review = biz.reviews.create!(
      :first_name => 'Sandy',
      :last_name => 'Strinni',
      :email => 'sandy.strinni@sa.com', 
      :details => 'They did great work.  We will use again BCI services when we need to select a new service provider.',
      :rating => 5,
      :is_approved => false,
      :is_rejected => false)
      
    review.update_attributes!(:created_at => DateTime.current + 30)
    
    review = biz.reviews.create!(
      :first_name => 'Bill',
      :last_name => 'Dennis',
      :email => 'bdennis@sass.org', 
      :details => 'It has been wonderful working with BCI. They tried to fully understand our needs before ever starting their search.',
      :rating => 4,
      :is_approved => false,
      :is_rejected => false)
      
    review.update_attributes!(:created_at => DateTime.current + 30)

    review = biz.reviews.create!(
      :first_name => 'Dale',
      :last_name => 'Cooper',
      :email => 'dale.cooper@tpks.com', 
      :details => 'We found their work to be incredible and the people to be very helpful.',
      :rating => 4,
      :is_approved => true,
      :is_rejected => false)
      
    review.update_attributes!(:created_at => DateTime.current + 30)
    
    review = biz.reviews.create!(
      :first_name => 'Bill',
      :last_name => 'Snyder',
      :email => 'bsnyder@bostitch.com', 
      :details => 'Excellent work, will use again BCI services when we need to select a new service provider',
      :rating => 4,
      :is_approved => true,
      :is_rejected => false)
      
    review.update_attributes!(:created_at => DateTime.current + 30)
    
    25.times do |n|
      biz.reviews.create!(
        :first_name => Faker::Name.first_name, 
        :last_name => Faker::Name.last_name, 
        :email => Faker::Internet.email, 
        :details => Faker::Lorem.paragraph,
        :rating => 1 + rand(5),
        :is_approved => ((n % 2 == 0) && (n % 5 != 0)),
        :is_rejected => ((n % 2 != 0) && (n % 5 != 0)))
    end
       
    #Create recommendations 
    25.times do |n|
      biz.recommendations.create!(
        :first_name => Faker::Name.first_name, 
        :last_name => Faker::Name.last_name, 
        :email => Faker::Internet.email, 
        :message => Faker::Lorem.paragraph)
    end
           
    #Create inquiries 
    17.times do |n|
      biz.inquiries.create!(
        :first_name => Faker::Name.first_name, 
        :last_name => Faker::Name.last_name, 
        :email => Faker::Internet.email, 
        :details => Faker::Lorem.paragraph)
    end

    12.times do |n|
      biz.inquiries.create!(
        :first_name => Faker::Name.first_name, 
        :last_name => Faker::Name.last_name, 
        :email => Faker::Internet.email, 
        :details => Faker::Lorem.paragraph,
        :is_archived => true)
    end
    
    # Create link clicks
    urls = ['http://bci.com', 'http://bci.com/reviews', 'http://bci.com/content/article/4', 'http://bci.com/events/5']
    rec_refs = (1..50).to_a
    platform_ids = Platform.all(:select => :id).map { |x| x.id }
    resource_types = PlatformPost.resource_types.values
    
    148.times do |n|
      biz.page_views.create!(:url => urls.rotate![0],
        :business_id => biz.id,
        :resource_type_id => resource_types.rotate![0],
        :resource_id => rec_refs.rotate![0],
        :channel_type_id => 1,
        :platform_id => 0,
        :created_at => Date.today - rand(1095)) 
    end

    359.times do |n|
      biz.page_views.create!(:url => urls.rotate![0],
        :business_id => biz.id,
        :resource_type_id => resource_types.rotate![0],
        :resource_id => rec_refs.rotate![0],
        :channel_type_id => 2,
        :platform_id => platform_ids.rotate![0],
        :created_at => Date.today - rand(1095)) 
    end
    
    50.times do |n|
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
      user_handle = first_name.first + last_name
      biz_name = Faker::Company.name
      
      user = User.create!(:email => Faker::Internet.email, :password => 'password', :password_confirmation => 'password', :is_admin => true)
      user.reload

      UserProfile.create!(
          :user => user,
          :first_name => first_name, 
          :last_name => last_name, 
          :facebook => 'http://facebook.com/' + user_handle, 
          :twitter => 'http://twitter.com/' + user_handle, 
          :google_plus => 'http://plus.google.com/' + user_handle,
          :linked_in => 'http://linkedin.com/' + user_handle,
          :biography => Faker::Lorem.paragraph,
          :city => Faker::Address.city,
          :state => Faker::Address.state_abbr,
          :updated_at => '2011-08-01 20:18:35',
          :created_at => '2011-08-01 20:18:33',
          :avatar_file_name => 'IMG_4634-1.jpg', 
          :avatar_content_type => 'image/jpeg', 
          :avatar_file_size => 3196303, 
          :avatar_updated_at => '2011-08-02 20:46:45', 
          :screen_name => user_handle)
      
      biz_name = Faker::Company.name
      biz_handle = biz_name.gsub(/[^[:alnum:]]/, '') 
      
      biz = user.businesses.create!(
          :name => biz_name,
          :phone => Faker::PhoneNumber.phone_number,
          :website => Faker::Internet.url,
          :facebook => 'http://facebook.com/' + biz_handle, 
          :twitter => 'http://twitter.com/' + biz_handle, 
          :google_plus => 'http://plus.google.com/' + biz_handle,
          :linked_in => 'http://linkedin.com/' + biz_handle,
          :biography => Faker::Company.bs,
          :address_1 => Faker::Address.street_address,
          :address_2 => nil,
          :city => Faker::Address.city,
          :state => Faker::Address.state_abbr,
          :zip_code => Faker::Address.zip_code)
      biz.reload
          
      10.times do |n|
          biz.reviews.create!(
            :first_name => Faker::Name.first_name, 
            :last_name => Faker::Name.last_name, 
            :email => Faker::Internet.email, 
            :details => Faker::Lorem.paragraph,
            :rating => 1 + rand(5),
            :is_approved => ((n % 2 == 0) && (n % 5 != 0)),
            :is_rejected => ((n % 2 != 0) && (n % 5 != 0)))
      end
    end
  end
end