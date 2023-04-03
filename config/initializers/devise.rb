# frozen_string_literal: true

Devise.setup do |config|
  config.confirm_within = 2.hours
end
