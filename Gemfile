source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.1'
#gem 'sqlite3'
gem 'pg', '~> 0.21'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Custom gems
gem 'slim-rails'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'will_paginate', '~> 3.1.0'
gem 'jquery-rails'
gem 'jquery-turbolinks'

gem 'momentjs-rails', '>= 2.9.0'
gem 'bootstrap3-datetimepicker-rails', '~> 4.14.30'
gem 'bootstrap_form'
gem "dynamic_form"

gem 'fullcalendar-rails'
gem 'devise'
gem 'faker'
gem 'rubocop', require: false

gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'
gem 'jquery-datatables-rails', '~> 3.4.0'
gem 'i18n-js'
gem 'net-ldap'

group :deploy do
  gem 'capistrano', '= 3.6.1'
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-bundler', '~> 1.2'
  gem 'capistrano-rvm'
  gem 'capistrano3-puma'
end
