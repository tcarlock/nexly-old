# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

                                
#Create users
user = User.create!(:email => 'timothy.carlock@gmail.com', :password => 'password', :password_confirmation => 'password', :is_admin => true)

profile = UserProfile.find_by_user_id(user.id)
profile.update_attributes(
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
                :avatar_file_name => "IMG_4634-1.jpg", 
                :avatar_content_type => "image/jpeg", 
                :avatar_file_size => 3196303, 
                :avatar_updated_at => "2011-08-02 20:46:45", 
                :screen_name => "tcarlock")
profile.save

#Create standard users                
user = User.create!(:email => 'jcarlock@gmail.com', :password => 'password', :password_confirmation => 'password', :is_admin => false)

profile = UserProfile.find_by_user_id(user.id)
profile.update_attributes(
                :first_name => 'Jon', 
                :last_name => 'Carlock', 
                :facebook => 'jcarl', 
                :twitter => 'jcarl', 
                :google_plus => 'jcarl',
                :linked_in => 'jcarl',
                :biography => 'I''m an engineering consultant in St Louis focusing on corporate projects',
                :city => 'St Louis',
                :state => 'MO',
                :updated_at => '2011-08-01 20:18:35',
                :created_at => '2011-08-01 20:18:33',
                :screen_name => "jcarlock")
profile.save
                
user = User.create!(:email => 'bcol@gmail.com', :password => 'password', :password_confirmation => 'password', :is_admin => false)

profile = UserProfile.find_by_user_id(user.id)
profile.update_attributes(
                :first_name => 'Bill', 
                :last_name => 'Collins', 
                :facebook => 'bcol', 
                :twitter => 'bcol', 
                :google_plus => 'bcol',
                :linked_in => 'bcol',
                :biography => 'I''m a financial consultant in Boston focusing on asset allocation and manager selection',
                :city => 'Boston',
                :state => 'MA',
                :updated_at => '2011-08-01 20:18:35',
                :created_at => '2011-08-01 20:18:33',
                :screen_name => "bcollins")
profile.save

user = User.create!(:email => 'jlester@gmail.com', :password => 'password', :password_confirmation => 'password', :is_admin => false)

profile = UserProfile.find_by_user_id(user.id)
profile.update_attributes(
                :first_name => 'Jay', 
                :last_name => 'Lester', 
                :facebook => 'Lester', 
                :twitter => 'Lester', 
                :google_plus => 'Lester',
                :linked_in => 'Lester',
                :biography => 'I''m a business consultant in Boston focusing on business strategy and contingency planning',
                :city => 'New York',
                :state => 'NY',
                :updated_at => '2011-08-01 20:18:35',
                :created_at => '2011-08-01 20:18:33',
                :screen_name => "jlester")
profile.save

user = User.create!(:email => 'sally.harding@gmail.com', :password => 'password', :password_confirmation => 'password', :is_admin => false)

profile = UserProfile.find_by_user_id(user.id)
profile.update_attributes(
                :first_name => 'Sally', 
                :last_name => 'Harding', 
                :facebook => 'harding', 
                :twitter => 'harding', 
                :google_plus => 'harding',
                :linked_in => 'harding',
                :biography => 'I''m a graphic designer in Chicago focusing on branding and creative marketing',
                :city => 'Chicago',
                :state => 'IL',
                :updated_at => '2011-08-01 20:18:35',
                :created_at => '2011-08-01 20:18:33',
                :screen_name => "sharding")
profile.save

#Create businesses
User.find(1).businesses.create!(
                :name => 'Nexly', 
                :website => 'http://nexly.com', 
                :facebook => 'http://facebook.com/nexlyllc', 
                :twitter => 'http://twitter.com/nexlyllc', 
                :google_plus => 'http://plus.google.com/nexlyllc',
                :linked_in => 'http://linkedin.com/nexlyllc',
                :biography => 'We provide technology and services to help small businesses find and select service providers',
                :address_1 => '1408 Rhode Island St',
                :address_2 => nil,
                :city => 'San Francisco',
                :state => 'CA',
                :zip_code => '94107',
                :updated_at => '2011-08-01 20:18:35',
                :created_at => '2011-08-01 20:18:33',
                :avatar_file_name => "logo.png", 
                :avatar_content_type => "image/png", 
                :avatar_file_size => 3196303, 
                :avatar_updated_at => "2011-08-02 20:46:45")
                
User.find(2).businesses.create!(
                :name => 'Acme Consulting',
                :website => 'acme.com',
                :facebook => 'AcmeConsulting', 
                :twitter => 'AcmeConsulting', 
                :google_plus => 'AcmeConsulting',
                :linked_in => 'AcmeConsulting',
                :biography => 'We provide IT consulting services',
                :address_1 => '101 South Hanley Rd',
                :address_2 => nil,
                :city => 'St Louis',
                :state => 'MO',
                :zip_code => '60105',
                :updated_at => '2011-08-01 20:18:35',
                :created_at => '2011-08-01 20:18:33')
                
#Create reviews
25.times do |n|
  Business.find(1).reviews.create!(
                :name => 'Lorem ipsum name',
                :email => 'some.client@acme.com', 
                :details => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris malesuada nulla et nisi tincidunt posuere pellentesque urna mollis.',
                :rating => rand(5),
                :is_approved => n % 2 == 0,
                :user_id => 1 + rand(4))
end

Application.create!(
                :title => 'Reviews',
                :details => 'Reviews allows you to easily request and manage client reviews.  It also allows you to distribute those reviews to your various social media pages and your own website',
                :price => 24.99)

Application.create!(
                :title => 'Resources',
                :details => 'Resources allows you to easily publish and manage learning materials and information such as articles, white papers, links, etc.',
                :price => 34.99)
                
Platform.create!(:name => "twitter")
Platform.create!(:name => "facebook")
Platform.create!(:name => "linkedin")
Platform.create!(:name => "google plus")