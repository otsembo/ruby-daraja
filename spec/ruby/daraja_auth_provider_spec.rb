# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe 'DarajaAuthProvider' do
  it 'encodes data into base64 and authorizes sandbox request' do
    auth_provider = AppUtils.auth_provider
    invalid_provider = DarajaAuthProvider.create(key: 'hello', secret: 'world')
    expect(auth_provider.token).not_to eq(nil)
    expect(invalid_provider.token).to eq(nil)
  end
end
