# frozen_string_literal: true

require 'faraday'
require_relative 'app_utils'

module Pay
  include AppUtils
  # AppConfig class
  class AppConfig < AppUtils::BaseConfig

    def initialize(provider: nil)
      super(is_sandbox: provider.is_sandbox)
    end

    # register all request types (fail / success) urls
    def register_urls
      @connection.post('/mpesa/c2b/v1/registerurl') do |req|
        req.headers['Authorization'] = "Bearer #{_auth_provider.token}"
        req.body = {
          ShortCode: _short_code,
          ResponseType: 'Completed',
          ConfirmationURL: _confirmation_url,
          ValidationURL: _validation_url
        }.to_json
      end
    end
  end

  class Bill < Payment; end

  class Goods < Payment; end

  # initialize Payment class
  class Payment; end
end
