require 'http'
require 'plutto/utils'
require 'plutto/errors'
require 'plutto/version'
require 'plutto/constant'
require 'json'

class Plutto::Client
  include Plutto::Utils
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

  private

  def get(path, **params)
    Plutto::Utils.create_instance(request('get').call(path, **params))
  end

  def all(path, **params)
    Plutto::Utils.create_all_instances(request('get').call(path, **params))
  end

  def post(path, **params)
    Plutto::Utils.create_instance(request('post').call(path, **params))
  end

  def patch(path, **params)
    Plutto::Utils.create_instance(request('patch').call(path, **params))
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

  def make_request(method, resource, parameters)
    resource = "#{Plutto::SCHEME}#{Plutto::BASE_URL}#{resource}" unless resource.include? 'https'
    client.send(method, resource, parameters)
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

  def raise_custom_error(error)
    raise error_class(error[:code]).new(error[:message], error[:docs_url])
  end

  def error_class(snake_code)
    pascal_code = snake_code.camelize
    class_name = pascal_code.end_with?('Error') ? pascal_code : "#{pascal_code}Error"
    Module.const_get("Plutto::Errors::#{class_name}")
  end
end
