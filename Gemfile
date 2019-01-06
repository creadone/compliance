# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

ruby '2.6.0'

group :production do
  gem 'puma',     '3.12.0'
  gem 'rack',     '2.0.6'
  gem 'sinatra',  '2.0.5'
end

group :test, :development do
  gem 'rack-test', require: 'rack/test'
  gem 'rspec'
  gem 'rubocop', require: false
  gem 'webmock'
end
