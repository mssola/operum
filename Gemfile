# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.2.2'

# Rails itself :)
gem 'rails', '~> 7.1.3'
gem 'rails-i18n', '~> 7.0.0'

# The original asset pipeline for Rails.
gem 'sprockets-rails'

# sqlite3 should be fine for this project, and we keep things simpler.
gem 'sqlite3', '~> 1.4'

# Web server.
gem 'puma', '>= 5.0'

# Use JavaScript with ESM import maps.
gem 'importmap-rails'

# Hotwire's SPA-like page accelerator.
gem 'turbo-rails'

# Hotwire's modest JavaScript framework.
gem 'stimulus-rails'

# Use Active Model has_secure_password.
gem 'bcrypt', '~> 3.1.7'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants.
gem 'image_processing', '~> 1.2'

group :development, :test do
  gem 'debug', platforms: %i[mri windows]

  # Security
  gem 'brakeman', require: false
  gem 'bundle-audit', require: false
end

group :development do
  # Use console on exceptions pages.
  gem 'web-console'

  # Convenient & prettier printer.
  gem 'awesome_print'

  # Style
  gem 'rubocop', require: false
  gem 'rubocop-minitest', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
end

group :test do
  # System testing.
  gem 'capybara'
  gem 'selenium-webdriver'
end
