require 'http'
require 'plutto/utils'
require 'plutto/errors'
require 'plutto/constants'
require 'plutto/version'
require 'plutto/resources/customer'
require 'json'

module Plutto
  class Client
    include Utils
    def initialize(api_key)
      @api_key = api_key
      @user_agent = "plutto/#{Plutto::VERSION}"
      @headers = {
        "Authorization": "Bearer #{@api_key}",
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      }
      @default_params = {}
    end

    def to_s
      visible_chars = 8
      hidden_part = '*' * (@api_key.size - visible_chars)
      visible_key = @api_key.slice(0, visible_chars)
      "Client(🔑=#{hidden_part + visible_key}"
    end

    def create_customer(**params)
      customer = post.call('customers', **params)[:customer]
      Customer.new(**customer, client: self)
    end

    def get_customers
      get.call('customers')[:customers].map { |data| Customer.new(**data, client: self) }
    end

    def get_customer(customer_id:)
      customer = get.call("customers/#{customer_id}")[:customer]
      Customer.new(**customer, client: self)
    end

    def update_customer(customer_id:, **params)
      customer = patch.call("customers/#{customer_id}", **params)[:customer]
      Customer.new(**customer, client: self)
    end

    def delete_customer(customer_id:)
      delete.call("customers/#{customer_id}")
    end

    private

    def get
      request('get')
    end

    def post
      request('post')
    end

    def patch
      request('patch')
    end

    def delete
      request('delete')
    end

    def request(method)
      proc do |resource, **kwargs|
        parameters = { json: { **kwargs } }
        response = make_request(method, resource, parameters)
        content = JSON.parse(response.body, symbolize_names: true) if !response.body.to_s.empty?

        if response.status.client_error? || response.status.server_error?
          raise_custom_error(content[:error])
        end

        content
      end
    end

    def client
      @client ||= HTTP.headers(@headers)
    end

    def make_request(method, resource, parameters)
      url = "#{Plutto::Constants::SCHEME}#{Plutto::Constants::BASE_URL}#{resource}"
      client.send(method, url, parameters)
    end

    def raise_custom_error(error)
      raise error_class(error[:code]).new(error[:message], error[:doc_url])
    end

    def error_class(snake_code)
      pascal_code = Utils.snake_to_pascal(snake_code)
      class_name = pascal_code.end_with?('Error') ? pascal_code : "#{pascal_code}Error"
      Module.const_get("Plutto::Errors::#{class_name}")
    end
  end
end
