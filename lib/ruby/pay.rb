# frozen_string_literal: true

require 'faraday'
require_relative 'app_utils'

module Pay
  include AppUtils
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

  # initialize Payment class
  class Payment
    attr_reader :config, :payment_credentials, :push_type
    attr_accessor :pass_key

    C2B = %w[CustomerPayBillOnline CustomerBuyGoodsOnline].freeze
    def initialize(config: AppConfig.new, pass_key: nil, push_type: 0)
      @config = config
      @pass_key = pass_key
      @push_type = push_type
      @payment_credentials = encode_password
    end

    # send STK Push request
    # @param [String] phone_number
    # @param [String] amount
    # @param [String] reference
    # @param [String] description
    # @return [Hash] response
    def send(phone_number:, amount:, reference:, description:)
      response = @connection.post('/mpesa/stkpush/v1/processrequest') do |req|
        req.headers['Authorization'] = "Basic #{@provider}"
        req.body = {
          BusinessShortCode: @config.short_code,
          Password: @payment_credentials.password,
          Timestamp: @payment_credentials.timestamp,
          TransactionType: C2B[@push_type],
          Amount: amount,
          PartyA: phone_number,
          PartyB: @config.short_code,
          PhoneNumber: phone_number,
          CallBackURL: @config.confirmation_url,
          AccountReference: reference,
          TransactionDesc: description
        }.to_json
      end
      JSON.parse(response.body)
    end

    private

    def encode_password
      timestamp = Time.now.strftime('%Y%m%d%H%M%S').to_s.to_i
      {
        timestamp: timestamp,
        password: Base64.strict_encode64("#{@config.short_code}#{@pass_key}#{timestamp}")
      }
    end
  end
end
