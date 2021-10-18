RSpec.shared_examples 'unauthorized endpoint' do |method|
  let(:api_key) { 'invalid api_key' }
  let(:client) { described_class.new(api_key) }
  let(:params) {}

  it 'raises UnauthorizedError', :vcr do
    expect_to_raise(method, params, 'UnauthorizedError')
  end
end

RSpec.shared_examples 'resource not found' do |method|
  let(:params) {}

  it 'raises ResourceNotFoundError', :vcr do
    expect_to_raise(method, params, 'ResourceNotFoundError')
  end
end

RSpec.shared_examples 'unprocessable entity' do |method|
  let(:params) {}

  it 'raises UnprocessableEntityError', :vcr do
    expect_to_raise(method, params, 'UnprocessableEntityError')
  end
end

def expect_to_raise(method, params, error_name)
  expect { params.nil? ? client.send(method) : client.send(method, **params) }
    .to(raise_error(an_instance_of(Module.const_get("Plutto::Errors::#{error_name}"))))
end
