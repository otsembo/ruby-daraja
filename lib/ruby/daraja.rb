# frozen_string_literal: true

require_relative 'daraja/version'
require_relative 'daraja_auth_provider'

module Ruby
  module Daraja
    class Error < StandardError; end

    # import all externally defined classes
    class AuthProvider < DarajaAuthProvider; end
  end
end
