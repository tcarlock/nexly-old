namespace :app do
  desc <<-DESC
      Drop and re-create development database
    DESC
    
  task :remount_database => [:environment] do
    Rake::Task['db:drop'].execute
    Rake::Task['db:create'].execute
    Rake::Task['db:migrate'].execute
    Rake::Task['db:seed'].execute
    Rake::Task['app:load_demo_data'].execute
    Rake::Task['ts:# index'].execute
    Rake::Task['ts:start'].execute
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

    #Create demo user, business and reviews
    user = User.create!(:email => 'timothy.carlock@gmail.com', :password => 'password', :password_confirmation => 'password', :is_admin => true)
    user.reload
    
    user.profile.update_attributes!(
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
        :avatar_updated_at => '2011-08-02 20:46:45')
        
    biz.reload
  
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
    
    50.times do |n|
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
      user_handle = first_name.first + last_name
      biz_name = Faker::Company.name
      
      user = User.create!(:email => Faker::Internet.free_email, :password => 'password', :password_confirmation => 'password', :is_admin => true)
      user.reload

      user.profile.update_attributes!(
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