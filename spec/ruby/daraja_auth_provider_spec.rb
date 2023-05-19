# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe 'DarajaAuthProvider' do
  let(:invalid_provider) { DarajaAuthProvider.create(key: 'hello', secret: 'world') }
  let(:auth_provider) do
    DarajaAuthProvider.create(key: ENV.fetch('CONSUMER_KEY', nil), secret: ENV.fetch('CONSUMER_SECRET', nil))
  end
  let(:env_auth_provider) { TestUtils.new._auth_provider }

  it 'encodes data into base64 and authorizes sandbox request' do
    expect(auth_provider.token && env_auth_provider.token).not_to be_nil
    expect(invalid_provider.token).to be_nil
  end
end
