# frozen_string_literal: true

require 'faraday'

module Pay
  class Bill < Payment; end

  class Goods < Payment; end

  # initialize Payment class
  class Payment; end
end
