# frozen_string_literal: true

require_relative 'daraja/version'
require_relative 'daraja_auth_provider'
require_relative 'pay'

module Ruby
  module Daraja
    include AppUtils
    include Pay
    class Error < StandardError; end

    # import all externally defined classes
    class AuthProvider < DarajaAuthProvider; end
  end
end
