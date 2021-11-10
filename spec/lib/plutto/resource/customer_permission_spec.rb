RSpec.describe Plutto::CustomerPermission do
  let(:data) do
    {
      current_usage: 0,
      limit: 'Infinity',
      allowed: true,
      name: 'Despachos'
    }
  end

  let(:permission) { described_class.new(**data) }

  it 'create an instance of CustomerPermission' do
    expect(permission).to be_an_instance_of(described_class)
  end

  it 'print the Pricing name and currency when to_s is called' do
    expect(permission.to_s).to eq('CustomerPermission: Despachos')
  end
end
