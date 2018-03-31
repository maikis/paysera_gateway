module PayseraGateway
  module Errors
    # Parameter validation error class.
    class ValidationError < StandardError
      attr_reader :details
      def initialize(message, details)
        # Details should be passed in as Hash.
        @details = details
        super(message)
      end
    end
  end
end
