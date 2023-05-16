# frozen_string_literal: true

# Application Utilities
module AppUtils
  # fetch consumer key from environment variables
  def self.consumer_key
    ENV.fetch('CONSUMER_KEY')
  end

  # fetch consumer secret from environment variables
  def self.consumer_secret
    ENV.fetch('CONSUMER_SECRET')
  end

  # create a new instance of DarajaAuthProvider class in sandbox mode
  def self.auth_provider
    DarajaAuthProvider.create(
      key: consumer_key,
      secret: consumer_secret
    )
  end
end
