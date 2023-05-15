# frozen_string_literal: true

require 'base64'
require 'faraday'

# Create Access Token for Daraja Requests
class DarajaAuthProvider
  attr_accessor :connection, :url, :token
  attr_writer :is_sandbox, :consumer_key, :consumer_secret
  attr_reader :request_token

  def initialize(consumer_key: nil, consumer_secret: nil, is_sandbox: true)
    @is_sandbox = is_sandbox
    @consumer_key = consumer_key
    @consumer_secret = consumer_secret
    @connection = Faraday.new(url: toggle_base_url, headers: { 'Content-Type' => 'application/json' }) do |faraday|
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
    end
    @request_token = create_auth_token
    @token = get_token
  end

  # Get Access Token
  def get_token
    @response = @connection.get('/oauth/v1/generate?grant_type=client_credentials') do |req|
      req.headers['Authorization'] = "Basic #{@request_token}"
    end
    return unless @response.status == 200

    @token = JSON.parse(@response.body)['access_token']
    @token
  end

  # abstract constructor logic into method
  # defaults to development environment
  def self.create(key: nil, secret: nil, is_sandbox: true)
    DarajaAuthProvider.new(consumer_key: key, consumer_secret: secret, is_sandbox: is_sandbox)
  end

  private

  # Create an Authorization Token
  def create_auth_token
    key = @consumer_key || ENV.fetch('CONSUMER_KEY')
    secret = @consumer_secret || ENV.fetch('CONSUMER_SECRET')
    Base64.strict_encode64("#{key}:#{secret}")
  end

  # Toggle between sandbox and production daraja API urls
  def toggle_base_url
    @url = if @is_sandbox
             'https://sandbox.safaricom.co.ke/'
           else
             'https://api.safaricom.co.ke/'
           end
  end
end