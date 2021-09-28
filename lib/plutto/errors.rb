require 'plutto/constants'

module Plutto
  module Errors
    class PluttoError < StandardError
      def initialize(message, doc_url = Plutto::Constants::GENERAL_DOC_URL)
        @message = message
        @doc_url = doc_url
      end

      def message
        "\n#{@message}\nPlease check the docs at: #{@doc_url}"
      end

      def to_s
        message
      end
    end

    class InvalidRequestError < PluttoError; end

    class BadRequestError < PluttoError; end

    class UnprocessableEntityError < PluttoError; end

    class UnauthorizedError < PluttoError; end

    class NotFoundError < PluttoError; end

    class InternalServerError < PluttoError; end
  end
end
