# frozen_string_literal: true

#
# require_relative ''

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

  # Default utility class
  # @return [Default] default
  class Default
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
      Pay::AppConfig.setup(
        provider: _auth_provider,
        short_code: _short_code,
        validation_url: _validation_url,
        confirmation_url: _confirmation_url
      )
    end

    ## FETCH ENVIRONMENT VARIABLES
    # fetch consumer key from environment variables
    # @return [String] consumer_key
    # @raise [RuntimeError] if consumer key is not set
    def _consumer_key
      ENV.fetch('CONSUMER_KEY') do
        raise 'Consumer Key not set'
      end
    end

    # fetch consumer secret from environment variables
    # @return [String] consumer_secret
    # @raise [RuntimeError] if consumer secret is not set
    def _consumer_secret
      ENV.fetch('CONSUMER_SECRET') do
        raise 'Consumer Secret not set'
      end
    end

    # fetch Validation URL from environment variables
    # @return [String] validation_url
    # @raise [RuntimeError] if validation url is not set
    def _validation_url
      ENV.fetch('VALIDATION_URL') do
        raise 'Validation URL not set'
      end
    end

    # fetch Confirmation URL from environment variables
    # @return [String] confirmation_url
    # @raise [RuntimeError] if confirmation url is not set
    def _confirmation_url
      ENV.fetch('CONFIRMATION_URL') do
        raise 'Confirmation URL not set'
      end
    end

    # fetch sandbox mode from environment variables
    # @return [Boolean] is_sandbox
    # default: true
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

end
