# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe AppUtils do
  context 'when using environment variables' do
    let(:app_utils) { AppUtils::Default.new }

    it 'has valid API consumer and secret keys' do
      expect { app_utils._consumer_key }.not_to raise_error ArgumentError
      expect { app_utils._consumer_secret }.not_to raise_error ArgumentError
    end

    it 'has valid payment URLS (validation and confirmation)' do
      expect { app_utils._validation_url }.not_to match_error
      expect { app_utils._confirmation_url }.not_to match_error
    end

    it 'has valid short code' do
      expect { app_utils._short_code }.not_to match_error
    end
  end
end

def match_error
  raise_error(ArgumentError)
end
