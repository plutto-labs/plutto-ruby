module Plutto
  # A handful of run-of-the-mill utilities
  module Utils
    extend self

    # If the key exists, you will get that key-value pair.
    #
    # @param dict_ [Hash] the hash to pick from
    # @param key [String] the key to look at
    # @return [Hash] the key-value pair or an empty hash
    def pick(dict_, key)
      key = key.to_sym
      if dict_.key?(key)
        { "#{key}": dict_[key] }
      else
        {}
      end
    end

    # Transform query params to api url suffix.
    #
    # @param q_status [String] query by status
    # @param q_customer [String] query by customer
    # @return [String]
    def concat_query_to_url(q_status, q_customer)
      q_status = q_status && "q[status_eq]=#{q_status}"
      q_customer = q_customer && "q[customer_eq]=#{q_customer}"
      suffix = [q_status, q_customer].compact.join('&')
      suffix.present? ? "?#{suffix}" : ''
    end
  end
end
