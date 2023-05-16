# frozen_string_literal: true

# AppUtils module
module AppUtils
  def self.consumer_key
    ENV.fetch('CONSUMER_KEY')
  end

  def self.consumer_secret
    ENV.fetch('CONSUMER_SECRET')
  end

  def self.auth_provider
    DarajaAuthProvider.create(
      key: consumer_key,
      secret: consumer_secret
    )
  end
end
