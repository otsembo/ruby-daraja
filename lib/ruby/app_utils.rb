# frozen_string_literal: true

# Application Utilities
module AppUtils
  # fetch consumer key from environment variables
  def _consumer_key
    ENV.fetch('CONSUMER_KEY')
  end

  # fetch consumer secret from environment variables
  def _consumer_secret
    ENV.fetch('CONSUMER_SECRET')
  end

  # create a new instance of DarajaAuthProvider class in sandbox mode
  def _auth_provider
    DarajaAuthProvider.create(
      key: _consumer_key,
      secret: _consumer_secret
    )
  end

  # fetch Validation URL from environment variables
  def self.validation_url
    ENV.fetch('VALIDATION_URL')
  end

  # fetch Confirmation URL from environment variables
  def self.confirmation_url
    ENV.fetch('CONFIRMATION_URL')
  end
end
