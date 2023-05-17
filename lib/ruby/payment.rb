# frozen_string_literal: true

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
