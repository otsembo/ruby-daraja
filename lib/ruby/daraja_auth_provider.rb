# frozen_string_literal: true

require 'base64'
require 'faraday'
require_relative 'app_utils'

# Create Access Token for Daraja Requests
class DarajaAuthProvider < AppUtils::BaseConfig
  attr_accessor :url, :token
  attr_writer :consumer_key, :consumer_secret
  attr_reader :request_token, :is_sandbox

  def initialize(consumer_key: nil, consumer_secret: nil, is_sandbox: false)
    super(is_sandbox: is_sandbox)
    @consumer_key = consumer_key
    @consumer_secret = consumer_secret
    @request_token = create_auth_token
    @token = fetch_token
  end

  # create a new instance of DarajaAuthProvider class in sandbox mode (default)
  # @return [DarajaAuthProvider] auth_provider
  def self.create(key: nil, secret: nil, is_sandbox: true)
    DarajaAuthProvider.new(consumer_key: key, consumer_secret: secret, is_sandbox: is_sandbox)
  end

  private

  # create an authorization token from consumer key and secret
  # @return [String] token
  def create_auth_token
    key = @consumer_key
    secret = @consumer_secret
    Base64.strict_encode64("#{key}:#{secret}")
  end

  # fetch authorization token from daraja API
  # @return [String] token
  def fetch_token
    response = @connection.get('/oauth/v1/generate?grant_type=client_credentials') do |req|
      req.headers['Authorization'] = "Basic #{@request_token}"
    end
    begin
      @token = JSON.parse(response.body)['access_token']
    rescue JSON::ParserError => _e
      return nil
    end
    @token.to_str
  end
end
