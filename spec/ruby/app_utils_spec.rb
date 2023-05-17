# frozen_string_literal: true

require_relative '../spec_helper'
class AppUtilsTest
  include AppUtils
end

RSpec.describe AppUtils do

  context 'when using environment variables' do
    let(:app_utils) { AppUtilsTest.new }

    it 'has valid API consumer and secret keys' do
      expect(app_utils._consumer_key).not_to be_nil
      expect(app_utils._consumer_secret).not_to be_nil
    end

    it 'has valid payment URLS (validation and confirmation)' do
      expect(app_utils._validation_url).not_to be_nil
      expect(app_utils._confirmation_url).not_to be_nil
    end
  end
end
