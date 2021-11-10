RSpec.shared_examples 'plutto client test' do |method|
  let(:resource_client) {}

  it 'calls method on respective client' do
    allow(resource_client).to receive(method.to_sym)
    client.send(method)
    expect(resource_client).to have_received(method.to_sym).once
  end
end

RSpec.shared_examples 'plutto client test with params' do |method|
  let(:resource_client) {}
  let(:params) {}

  it 'calls method on respective client' do
    allow(resource_client).to receive(method.to_sym).with(**params)
    client.send(method, **params)
    expect(resource_client).to have_received(method.to_sym).with(**params).once
  end
end

RSpec.shared_examples 'plutto client test with id' do |method|
  let(:resource_client) {}
  let(:id) {}

  it 'calls method on respective client' do
    allow(resource_client).to receive(method.to_sym).with(**id)
    client.send(method, *id.values)
    expect(resource_client).to have_received(method.to_sym).with(**id).once
  end
end

RSpec.shared_examples 'plutto client test id and params' do |method|
  let(:resource_client) {}
  let(:params) {}
  let(:params_clone) { params.clone }
  let(:id) { params.delete(params.keys.first) }

  it 'calls method on respective client' do
    allow(resource_client).to receive(method.to_sym).with(**params_clone)
    client.send(method, id, **params)
    expect(resource_client).to have_received(method.to_sym).with(**params_clone).once
  end
end
