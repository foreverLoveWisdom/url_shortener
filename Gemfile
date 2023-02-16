# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.3'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.4', '>= 7.0.4.2'

# Pg is the Ruby interface to the PostgreSQL RDBMS. It works with PostgreSQL 9.3 and later.
gem 'pg', '~> 1.4', '>= 1.4.5'

# Easy way to build and manage commands (service objects)
gem 'simple_command', '~> 1.0', '>= 1.0.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

group :development, :test do
  # Combine 'pry' with 'byebug'. Adds 'step', 'next', 'finish', 'continue' and 'break' commands to control execution.
  gem 'pry-byebug', '~> 3.10', '>= 3.10.1'

  # Great Ruby debugging companion: pretty print Ruby objects to visualize their structure
  gem 'awesome_print', '~> 1.9', '>= 1.9.2'

  # Use Pry as your rails console
  gem 'pry-rails', '~> 0.3.9'

  # rspec-rails is a testing framework for Rails 5+.
  gem 'rspec-rails', '~> 6.0', '>= 6.0.1'

  # Faker, a port of Data::Faker from Perl, is used to easily generate fake data: names, addresses, phone numbers, etc.
  gem 'faker', '~> 3.1', '>= 3.1.1'

  # Factory Bot is a fixtures replacement with a straightforward definition syntax, support for multiple build strategies (saved instances, unsaved instances, attribute hashes, and stubbed objects), and support for multiple factories for the same class (user, admin_user, and so on), including factory inheritance.
  gem 'factory_bot_rails', '~> 6.2'
end

group :test do
  # Strategies for cleaning databases. Can be used to ensure a clean slate for testing.
  gem 'database_cleaner', '~> 2.0', '>= 2.0.1'

  # Code coverage for Ruby with a powerful configuration library and automatic merging of coverage across test suites
  gem 'simplecov', '~> 0.22.0', require: false
end

group :development do
  # Brakeman is a static analysis tool which checks Ruby on Rails applications for security vulnerabilities.
  gem 'brakeman', '~> 5.4'

  # bundler-audit provides patch-level verification for Bundled apps.
  gem 'bundler-audit', '~> 0.9.1'

  # Utility to install, configure, and extend Git hooks
  gem 'overcommit', '~> 0.60.0'

  # Guard is a command line tool to easily handle events on file system modifications.
  gem 'guard', '~> 2.18', require: false

  # Guard::RSpec automatically run your specs (much like autotest).
  gem 'guard-rspec', '~> 4.7', '>= 4.7.3', require: false
end

# A RuboCop extension focused on enforcing Rails best practices and coding conventions.
gem 'rubocop-rails', require: false

# RSpec-specific analysis for your projects, as an extension to RuboCop.
gem 'rubocop-rspec', require: false

# Performance optimization analysis for your projects, as an extension to RuboCop.
gem 'rubocop-performance', require: false
