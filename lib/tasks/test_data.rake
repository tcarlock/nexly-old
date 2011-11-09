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
      token: 'AAACVmYzueukBAPRUaQXZA6wiZAKpzBNJ8Yx3Jv2mU3HMLyfSBCbSjzm3m1ZB4an1ZAhwg8Qz9ZB7ZBunFJY0kyPXFgBJNhopRt8dYxe5c31QZDZD',
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
    
    UserProfile.create!(
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
      :name => 'David Hansson',
      :email => 'dhh@37signals.com', 
      :details => 'Great experience working with the firm - we saved time and $ by using their services to select a software development firm. Understood our needs quickly. Would use again',
      :rating => 5,
      :is_approved => true,
      :is_rejected => false,
      :user_id => 1 + rand(4))
      
    review.update_attributes!(:created_at => DateTime.current + 30)
      
    review = biz.reviews.create!(
      :name => 'Dale Cooper',
      :email => 'dale.cooper@tpks.com', 
      :details => 'Great experience working with the firm - we saved time and $ by using their',
      :rating => 5,
      :is_approved => false,
      :is_rejected => false,
      :user_id => 1 + rand(4))
      
    review.update_attributes!(:created_at => DateTime.current + 30)
    
    25.times do |n|
      biz.reviews.create!(
        :name => Faker::Name.name,
        :email => Faker::Internet.email, 
        :details => Faker::Lorem.paragraph,
        :rating => rand(5),
        :is_approved => ((n % 2 == 0) && (n % 5 != 0)),
        :is_rejected => ((n % 2 != 0) && (n % 5 != 0)),
        :user_id => 1 + rand(4))
    end
    
    # Create link clicks
    urls = ['http://bci.com', 'http://bci.com/reviews', 'http://bci.com/content/article/4', 'http://bci.com/events/5']
    rec_refs = (1..50).to_a
    platform_ids = Platform.all(:select => :id).map { |x| x.id }
    link_types = PageView.types.values
    
    359.times do |n|
      biz.page_views.create!(:url => urls.rotate![0],
        :platform_id => platform_ids.rotate![0],
        :reference_id => rec_refs.rotate![0],
        :link_type_id => link_types.rotate![0],
        :business_id => biz.id,
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
            :name => Faker::Name.name,
            :email => Faker::Internet.email, 
            :details => Faker::Lorem.paragraph,
            :rating => rand(5),
            :is_approved => ((n % 2 == 0) && (n % 5 != 0)),
            :is_rejected => ((n % 2 != 0) && (n % 5 != 0)),
            :user_id => 1 + rand(4))
      end
    end
  end
end