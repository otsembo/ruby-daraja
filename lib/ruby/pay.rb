# frozen_string_literal: true

require 'faraday'
require_relative 'app_utils'

module Pay
  class Config
    include AppUtils
    def initialize(**options)
      DarajaAuthProvider.create(**options)
    end

    def self.build
      _auth_provider
    end

    def register_urls; end
  end

  class Bill < Payment; end

  class Goods < Payment; end

  # initialize Payment class
  class Payment; end
end
