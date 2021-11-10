module Plutto
  module Errors
    class PluttoError < StandardError
      def initialize(message, doc_url = GENERAL_DOC_URL)
        super()

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

    class ResourceNotFoundError < PluttoError; end
  end
end
