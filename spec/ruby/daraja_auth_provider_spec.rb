# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe 'DarajaAuthProvider' do
  let(:auth_provider) { DarajaAuthProvider.create }
  let(:invalid_provider) { DarajaAuthProvider.create(key: 'hello', secret: 'world') }

  it 'encodes data into base64 and authorizes sandbox request' do
    expect(auth_provider.token).not_to be_nil
    expect(invalid_provider.token).to be_nil
  end
end
