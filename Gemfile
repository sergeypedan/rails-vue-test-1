# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby File.read(File.expand_path("../.ruby-version", __FILE__)).chomp

gem "bcrypt", "~> 3.1.7"
gem "bootsnap", ">= 1.4.2", require: false
# gem "jbuilder", "~> 2.7"
gem "jwt_sessions"
gem "puma", "~> 4.3"
gem "rack-cors"
gem "rails", "~> 6.0.2", ">= 6.0.2.2"
gem "redis"
gem "slim-rails"
gem "sqlite3", "~> 1.4"
gem "webpacker"

group :development, :test do
  gem "byebug", platforms: [:mri]
  gem "pry-rails"
  gem "pry-byebug"
end

group :development do
  gem "annotate"
  gem "listen", ">= 3.0.5", "< 3.2"
end
