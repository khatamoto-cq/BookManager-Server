source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.2'
gem 'mysql2', '>= 0.3.18', '< 0.5'
gem 'puma', '~> 3.7'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'

gem 'bcrypt', '~> 3.1.7'
gem 'knock'
gem 'active_model_serializers', '~> 0.10.4'
gem 'kaminari'
gem 'date_validator'
gem 'email_validator'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'guard-rspec'
end

group :test do
  gem 'simplecov', :require => false
  gem 'rspec-json_matcher'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'database_cleaner'
  gem 'faker'
  gem 'guard'
end
