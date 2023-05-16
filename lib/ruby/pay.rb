# frozen_string_literal: true

module Pay
  class Bill < Payment; end

  class Goods < Payment; end

  # initialize Payment class
  class Payment
    def initialize
      puts 'Payment initialized'
    end
  end
end
