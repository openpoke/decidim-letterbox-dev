# frozen_string_literal: true

source "https://rubygems.org"

ruby RUBY_VERSION

DECIDIM_VERSION = { git: "https://github.com/openpoke/decidim", branch: "0.26-lucerne" }

gem "decidim", DECIDIM_VERSION
# gem "decidim-conferences", DECIDIM_VERSION
# gem "decidim-consultations", DECIDIM_VERSION
# gem "decidim-elections", DECIDIM_VERSION
# gem "decidim-initiatives", DECIDIM_VERSION
gem "decidim-templates", DECIDIM_VERSION

gem "decidim-decidim_awesome", git: "https://github.com/decidim-ice/decidim-module-decidim_awesome"
gem 'decidim-reporting_proposals', git: "https://github.com/openpoke/decidim-module-reporting-proposals"
gem 'decidim-participatory_documents', git: "https://github.com/openpoke/decidim-module-participatory-documents"
gem 'decidim-term_customizer', git: "https://github.com/openpoke/decidim-module-term_customizer"

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
  gem "spring", "~> 2.1"
  gem "spring-watcher-listen", "~> 2.0"
  gem "web-console", "~> 4.2"
end

group :production do
  gem 'aws-sdk-s3', require: false
  gem 'sidekiq', "<7"
  gem 'sidekiq-cron'
end
