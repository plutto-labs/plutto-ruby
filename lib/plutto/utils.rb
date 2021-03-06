# A handful of run-of-the-mill utilities
module Plutto::Utils
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

  # Creates an object instaces from api response
  #
  # @param response [Hash] hash containing class name as first key and instance params as value
  # @return [Object] instace of the class name from the hash key value
  def create_instance(response)
    klass ||= response.keys.first
    params ||= response.values.first
    Module.const_get("Plutto::#{klass.to_s.singularize.camelize}").new(
      **params, client: @plutto_client
    )
  end

  # Creates a list of object instaces from api response
  #
  # @param response [Hash] hash containing class name as first key and data array as value
  # @return [Array] of ruby objects
  def create_all_instances(response)
    data = response.values.first
    data.map { |params| create_instance({ "#{response.keys.first}": params }) }
  end
end
