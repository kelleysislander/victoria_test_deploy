source 'http://rubygems.org'

gem 'rails', '3.1.0'
gem 'rack', '1.3.3'
gem 'mysql2', '>= 0.3'
gem 'capistrano'
gem 'capistrano-ext'
gem "haml"
gem "haml-rails"
gem "cancan"
gem 'rabl'
gem 'geocoder' # https://github.com/alexreisner/geocoder#readme
gem 'omniauth'
gem "jquery-rails"
gem 'kaminari' # rails g kaminari:views default
# gem 'nifty-generators', :group => :development # rails g nifty:scaffold authentication user_id:integer provider:string uid:string index create destroy
# gem 'omniauth-twitter' # needed for rails 3.1
# gem 'omniauth-facebook' # needed for rails 3.1
# gem 'nifty-generators' # rails g nifty:scaffold authentication user_id:integer provider:string uid:string index create destroy
# gem 'date_validator' # used in deal.rb
# gem 'mini_magick' # used with deal.badge_text and a background starburst to create the deal badge, a graphical icon (ie. "$50.00 off!" or "20% off!")
# gem 'rmagick' # as above
# gem 'carrierwave'
# gem 'therubyracer', :require => 'v8'

=begin
Omniauth
Billys-MacBook-Pro ~/Projects/victoria: rails g nifty:scaffold authentication user_id:integer provider:string uid:string index create destroy
     gemfile  mocha
      create  app/models/authentication.rb
      create  spec/models/authentication_spec.rb
      create  spec/fixtures/authentications.yml
      create  db/migrate/20111117221158_create_authentications.rb
      create  app/controllers/authentications_controller.rb
      create  app/helpers/authentications_helper.rb
      create  app/views/authentications/index.html.erb
       route  resources :authentications
      create  spec/controllers/authentications_controller_spec.rb

Account
Billys-MacBook-Pro ~/Projects/victoria: rails g nifty:scaffold Account name:string description:string contact_name:string contact_email:string
      create  app/models/account.rb
      create  spec/models/account_spec.rb
      create  spec/fixtures/accounts.yml
      create  db/migrate/20111130211725_create_accounts.rb
      create  app/controllers/accounts_controller.rb
      create  app/helpers/accounts_helper.rb
      create  app/views/accounts/index.html.erb
      create  app/views/accounts/show.html.erb
      create  app/views/accounts/new.html.erb
      create  app/views/accounts/edit.html.erb
      create  app/views/accounts/_form.html.erb
       route  resources :accounts
      create  spec/controllers/accounts_controller_spec.rb
=end

group :assets do
  # gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem "rspec-rails", ">= 2.6.1",        :group => [:development, :test]
gem "factory_girl_rails", ">= 1.1.0", :group => :test
gem "cucumber-rails", ">= 1.0.2",     :group => :test
gem "capybara", ">= 1.0.1",           :group => :test
gem "database_cleaner", ">= 0.6.7",   :group => :test
gem "launchy", ">= 2.0.5",            :group => :test
gem "devise", ">= 1.4.4" # https://github.com/plataformatec/devise#readme, after installing the gem: rails generate devise:install
gem "mocha", :group => :test
