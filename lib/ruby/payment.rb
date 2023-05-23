# frozen_string_literal: true

# initialize Payment class
class Payment
  attr_reader :config, :payment_credentials, :push_type
  attr_accessor :pass_key

  C2B = %w[CustomerPayBillOnline CustomerBuyGoodsOnline].freeze
  B2C = %w[BusinessPayment SalaryPayment PromotionPayment].freeze
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
  def initiate_stk_push(phone_number:, amount:, reference:, description:)
    response = @connection.post('/mpesa/stkpush/v1/processrequest') do |req|
      req.headers['Authorization'] = "Basic #{@config.provider.token}"
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

  # send B2C request
  # @param [String] phone_number
  # @param [String] amount
  # @param [String] remarks
  # @param [int] type
  # @param [String|nil] occasion
  # @return [Hash<String, String|nil>] response
  def initiate_b2c(phone_number:, amount:, remarks:, type: 0, occasion: nil)
    response = @connection.post('/mpesa/b2c/v1/paymentrequest') do |req|
      req.headers['Authorization'] = "Basic #{@config.provider.token}"
      req.body = {
        InitiatorName: @config.initiator_name,
        SecurityCredential: security_credential,
        CommandID: B2C[type],
        Amount: amount,
        PartyA: @config.short_code,
        PartyB: phone_number,
        Remarks: remarks,
        QueueTimeOutURL: @config.b2c_result_url,
        ResultURL: @config.b2c_result_url,
        Occasion: occasion
      }.to_json
    end
    JSON.parse(response)
  end

  # initiate balance request
  # @param [String?] remarks
  # @return [Hash<String, String|nil>] response
  def initiate_balance_request(remarks: nil)
    response = @connection.post('/mpesa/accountbalance/v1/query') do |req|
      req.headers['Authorization'] = "Basic #{@config.provider.token}"
      req.body = {
        Initiator: @config.initiator_name,
        SecurityCredential: security_credential,
        CommandID: 'AccountBalance',
        PartyA: @config.short_code,
        IdentifierType: 4,
        Remarks: remarks,
        QueueTimeOutURL: @config.balance_result_url,
        ResultURL: @config.balance_result_url
      }.to_json
    end
    JSON.parse(response)
  end

  private

  def encode_password
    timestamp = Time.now.strftime('%Y%m%d%H%M%S').to_s.to_i
    {
      timestamp: timestamp,
      password: Base64.strict_encode64("#{@config.short_code}#{@pass_key}#{timestamp}")
    }
  end

  def security_credential
    Base64.strict_encode64(OpenSSL::HMAC.hexdigest('sha256', @config.initiator_password, @config.ssl_certificate))
  end
end
