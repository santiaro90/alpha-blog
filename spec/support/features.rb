require 'support/features/auth_helper'

RSpec.configure do |config|
  config.include Features::AuthHelpers, type: :feature
end
