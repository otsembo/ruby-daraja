# frozen_string_literal: true

require_relative 'daraja/version'
require_relative 'daraja_auth_provider'

module Ruby
  module Daraja
    include DarajaAuthProvider
    class Error < StandardError; end

    # Your code goes here...
  end
end
