# frozen_string_literal: true

# Application Utilities
module AppUtils
  # base configuration class
  class BaseConfig
    attr_accessor :connection
    attr_writer :is_sandbox

    def initialize(is_sandbox: false)
      @is_sandbox = is_sandbox
      @connection = Faraday.new(url: toggle_base_url, headers: { 'Content-Type' => 'application/json' }) do |f|
        f.request :url_encoded
        f.adapter Faraday.default_adapter
      end
    end

    def toggle_base_url
      if @is_sandbox
        'https://sandbox.safaricom.co.ke/'
      else
        'https://api.safaricom.co.ke/'
      end
    end
  end

  # create Faraday connection object
  # @return [Faraday::Connection] conn
  def _connection
    Faraday.new(url: _toggle_base_url, headers: { 'Content-Type' => 'application/json' }) do |f|
      f.request :url_encoded
      f.adapter Faraday.default_adapter
    end
  end

  # toggle between sandbox and production daraja API urls
  # @return [String] url
  def _toggle_base_url
    if _is_sandbox
      'https://sandbox.safaricom.co.ke/'
    else
      'https://api.safaricom.co.ke/'
    end
  end

  # APP OBJECTS
  # create a new instance of DarajaAuthProvider class in sandbox mode
  def _auth_provider
    DarajaAuthProvider.create(
      key: _consumer_key,
      secret: _consumer_secret,
      is_sandbox: _is_sandbox
    )
  end

  # create a new instance of AppConfig class in sandbox mode
  # @return [AppConfig] app_config
  def _app_config
    AppConfig.new(provider: _auth_provider)
  end

  ## FETCH ENVIRONMENT VARIABLES
  # fetch consumer key from environment variables
  # @return [String] consumer_key
  def _consumer_key
    ENV.fetch('CONSUMER_KEY', nil)
  end

  # fetch consumer secret from environment variables
  # @return [String] consumer_secret
  def _consumer_secret
    ENV.fetch('CONSUMER_SECRET', nil)
  end

  # fetch Validation URL from environment variables
  # @return [String] validation_url
  def _validation_url
    ENV.fetch('VALIDATION_URL', nil)
  end

  # fetch Confirmation URL from environment variables
  # @return [String] confirmation_url
  def _confirmation_url
    ENV.fetch('CONFIRMATION_URL', nil)
  end

  # fetch sandbox mode from environment variables
  # @return [Boolean] is_sandbox
  def _is_sandbox
    ENV.fetch('IS_SANDBOX', true)
  end

  # fetch short code from environment variables
  # @return [String] short_code
  # @raise [RuntimeError] if short code is not set
  def _short_code
    ENV.fetch('SHORT_CODE') do
      raise 'Short Code not set'
    end
  end
end
