source 'https://rubygems.org'

ruby '2.2.2'

gem 'rails', '4.2.3'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
# gem 'therubyracer', platforms: :ruby
gem 'jquery-rails'
gem 'turbolinks'
gem 'sdoc', group: :doc
# gem 'bcrypt', '~> 3.1.7'
gem 'unicorn'
gem 'capistrano-rails', group: :development
gem 'mongoid'
gem 'attr_encrypted' #http://stackoverflow.com/questions/4343996/rails-storing-encrypted-data-in-database
gem 'jbuilder'
gem 'responders'

group :development, :test do
  gem 'pry'
  gem 'web-console'
  gem 'spring'
  gem 'rest-client'
  gem 'rspec-rails'
  gem 'spring-commands-rspec'
  gem 'guard', require: false
  gem 'guard-rspec', require: false
  gem 'guard-bundler', require: false
  gem 'factory_girl_rails', require: false
end

group :production do
  gem 'newrelic_rpm'
end
