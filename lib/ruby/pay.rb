# frozen_string_literal: true

require 'faraday'
require_relative 'payment'

# Main module for processing requests
module Pay
  # AppConfig class
  class AppConfig < AppUtils::BaseConfig
    attr_accessor :short_code, :confirmation_url, :validation_url
    attr_reader :provider

    def initialize(
      provider: DarajaAuthProvider.create,
      short_code: nil,
      confirmation_url: nil,
      validation_url: nil
    )
      super(is_sandbox: provider.is_sandbox)
      @short_code = short_code
      @confirmation_url = confirmation_url
      @validation_url = validation_url
      @provider = provider
    end

    # receive all inputs for payment setup
    def self.setup(
      provider: DarajaAuthProvider.create,
      short_code: nil,
      confirmation_url: nil,
      validation_url: nil
    )
      AppConfig.new(provider: provider,
                    short_code: short_code,
                    confirmation_url: confirmation_url,
                    validation_url: validation_url)
    end

    # register all request types (fail / success) urls
    # @return [Array] response
    def register_urls
      %w[Completed Cancelled].map { |status| setup_status(status) }
    end

    private

    # register url
    # @param [String] status
    # @return [Hash] response
    def setup_status(status)
      response = @connection.post('/mpesa/c2b/v1/registerurl') do |req|
        req.headers['Authorization'] = "Basic #{@provider.token}"
        req.body = {
          ShortCode: @short_code,
          ResponseType: status,
          ConfirmationURL: @confirmation_url,
          ValidationURL: @validation_url
        }.to_json
      end
      JSON.parse(response.body)
    end
  end

  # MPESA Pay Bill Online (C2B / B2C)
  class Bill < Payment
    def initialize(config: AppConfig.new, pass_key: nil)
      super(config: config, pass_key: pass_key, push_type: 0)
    end
  end

  # MPESA Buy Goods Online (C2B / B2C)
  class Goods < Payment
    def initialize(config: AppConfig.new, pass_key: nil)
      super(config: config, pass_key: pass_key, push_type: 1)
    end
  end
end
