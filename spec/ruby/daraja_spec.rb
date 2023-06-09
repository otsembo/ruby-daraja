# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe Ruby::Daraja do
  it 'has a version number' do
    expect(Ruby::Daraja::VERSION).not_to be_nil
  end

  it 'has an auth provider' do
    expect(Daraja::AuthProvider.new).not_to be_nil
  end

  it 'has a base configuration' do
    expect(AppUtils::BaseConfig.new).not_to be_nil
  end
end
