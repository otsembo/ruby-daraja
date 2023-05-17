# frozen_string_literal: true

require 'ruby/daraja'
require_relative '../lib/ruby/daraja_auth_provider'
require_relative '../lib/ruby/app_utils'
require_relative '../lib/ruby/pay'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
