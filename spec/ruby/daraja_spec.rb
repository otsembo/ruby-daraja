# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe Ruby::Daraja do
  it 'has a version number' do
    expect(Ruby::Daraja::VERSION).not_to be nil
  end
end
