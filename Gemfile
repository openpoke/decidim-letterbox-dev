# frozen_string_literal: true

source "https://rubygems.org"

ruby RUBY_VERSION

DECIDIM_VERSION="0.26.2"

gem "decidim", DECIDIM_VERSION
# gem "decidim-conferences", git: "https://github.com/decidim/decidim.git", branch: "develop"
# gem "decidim-consultations", git: "https://github.com/decidim/decidim.git", branch: "develop"
# gem "decidim-elections", git: "https://github.com/decidim/decidim.git", branch: "develop"
# gem "decidim-initiatives", git: "https://github.com/decidim/decidim.git", branch: "develop"
# gem "decidim-templates", git: "https://github.com/decidim/decidim.git", branch: "develop"

gem "bootsnap", "~> 1.7"

gem "puma", ">= 5.0.0"

gem "faker", "~> 2.14"

gem "wicked_pdf", "~> 2.1"

gem 'decidim-microsoft'

group :development, :test do
  gem "byebug", "~> 11.0", platform: :mri

  gem "brakeman"
  gem "decidim-dev", DECIDIM_VERSION
end

group :development do
  gem "letter_opener_web", "~> 2.0"
  gem "listen", "~> 3.1"
  gem "spring", "~> 2.0"
  gem "spring-watcher-listen", "~> 2.0"
  gem "web-console", "~> 4.2"
end

group :production do
  gem 'aws-sdk-s3', require: false
  gem 'sidekiq'
  gem 'sidekiq-cron', "~> 1.6.0"
end
