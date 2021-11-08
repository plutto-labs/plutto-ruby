require 'http'
require 'plutto/utils'
require 'plutto/errors'
require 'plutto/version'
require 'plutto/resources/customer'
require 'plutto/resources/product'
require 'plutto/resources/customer_permission'
require 'plutto/resources/permission_group'
require 'plutto/resources/meter_event'
require 'plutto/resources/invoice'
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
      @header_link = nil
      @header_link_pattern = '<(?<url>.*)>;\s*rel="(?<rel>.*)"'
    end

    def to_s
      visible_chars = 8
      hidden_part = '*' * (@api_key.size - visible_chars)
      visible_key = @api_key.slice(0, visible_chars)
      "Client(🔑=#{hidden_part + visible_key}"
    end

    def fetch_next
      next_ = header_link
      return if next_.nil?

      Enumerator.new do |yielder|
        while next_['next']
          yielder << all(next_['next'])
          next_ = header_link
        end
      end
    end

    def create_customer(**params)
      post('customers', **params)
    end

    def get_customers
      all('customers')
    end

    def get_customer(customer_id:)
      get("customers/#{customer_id}")
    end

    def update_customer(customer_id:, **params)
      patch("customers/#{customer_id}", **params)
    end

    def delete_customer(customer_id:)
      delete("customers/#{customer_id}")
    end

    def get_customer_permission(customer_id:, permission_name:)
      get("customers/#{customer_id}/has_permission/#{permission_name}")
    end

    def get_permission_groups
      all("permission_groups")
    end

    def create_meter_event(**params)
      post('meter_events', **params)
    end

    def get_products
      all("products")
    end

    def get_invoices(q_status = nil, q_customer = nil)
      suffix = Utils.concat_query_to_url(q_status, q_customer)
      all("invoices#{suffix}")
    end

    def get_invoice(invoice_id:)
      get("invoices/#{invoice_id}")
    end

    def invoice_mark_as(invoice_id:, **params)
      patch("invoices/#{invoice_id}/mark_as", **params)
    end

    def create_subscription(**params)
      post('subscriptions', **params)
    end

    def end_subscription(subscription_id:)
      patch("subscriptions/#{subscription_id}/end_subscription")
    end

    def add_pricings(subscription_id:, **params)
      patch("subscriptions/#{subscription_id}/add_pricings", **params)
    end

    def remove_pricings(subscription_id:, **params)
      patch("subscriptions/#{subscription_id}/remove_pricings", **params)
    end

    private

    def get(path, **params)
      Utils.create_instance(request('get').call(path, **params))
    end

    def all(path, **params)
      Utils.create_all_instances(request('get').call(path, **params))
    end

    def post(path, **params)
      Utils.create_instance(request('post').call(path, **params))
    end

    def patch(path, **params)
      Utils.create_instance(request('patch').call(path, **params))
    end

    def delete(path, **params)
      request('delete').call(path, **params)
    end

    def request(method)
      proc do |resource, **kwargs|
        parameters = { json: { **kwargs } }
        response = make_request(method, resource, parameters)
        content = JSON.parse(response.body, symbolize_names: true) unless response.body.to_s.empty?
        raise_custom_error(content[:error]) if error?(response)

        @header_link = response.headers.get('link')
        content
      end
    end

    def header_link
      return if @header_link.nil? || @header_link.empty?

      @header_link[0].split(',').reduce({}) { |dict, link| parse_headers(dict, link) }
    end

    def parse_headers(dict, link)
      matches = link.strip.match(@header_link_pattern)
      dict[matches[:rel]] = matches[:url]
      dict
    end

    def error?(response)
      response.status.client_error? || response.status.server_error?
    end

    def client
      @client ||= HTTP.headers(@headers)
    end

    def make_request(method, resource, parameters)
      resource = "#{Plutto::SCHEME}#{Plutto::BASE_URL}#{resource}" unless resource.include? 'https'
      client.send(method, resource, parameters)
    end

    def raise_custom_error(error)
      raise error_class(error[:code]).new(error[:message], error[:docs_url])
    end

    def error_class(snake_code)
      pascal_code = snake_code.camelize
      class_name = pascal_code.end_with?('Error') ? pascal_code : "#{pascal_code}Error"
      Module.const_get("Plutto::Errors::#{class_name}")
    end
  end
end
