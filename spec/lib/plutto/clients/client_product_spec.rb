require 'plutto/client'

RSpec.describe Plutto::ClientProduct do
  let(:api_key) { 'sk_live_0a641854b17cdfed9e98eb7cd3e9e2bfc2687a37470cc8ce71f31c49e33d037f' }
  let(:client) { described_class.new(api_key) }

  describe '.new' do
    it 'create an instance Client' do
      expect(client).to be_an_instance_of(described_class)
    end
  end

  describe '#get_products' do
    it 'every product as an instance', :vcr do
      products = client.get_products
      expect(products).to all(be_a(Plutto::Product))
    end

    it_behaves_like 'unauthorized endpoint', 'get_products'
  end
end
