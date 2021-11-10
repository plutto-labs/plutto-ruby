require 'plutto/client'

RSpec.describe Plutto::Client do
  let(:api_key) { 'sk_live_0a641854b17cdfed9e98eb7cd3e9e2bfc2687a37470cc8ce71f31c49e33d037f' }
  let(:client) { described_class.new(api_key) }
  let(:header_link) { ['<https://sandbox.getplutto.com/api/v1/customers?page=2>; rel="last", <https://sandbox.getplutto.com/api/v1/customers?page=2>; rel="next"'] }

  describe '.new' do
    it 'create an instance Client' do
      expect(client).to be_an_instance_of(described_class)
    end
  end

  describe '#fetch_next' do
    it 'returns Enumerator to paginate api request' do
      client.instance_variable_set(:@header_link, header_link)
      enumerator = client.fetch_next
      expect(enumerator).to be_a(Enumerator)
    end

    context 'when theres no pagination' do
      it 'returns nil' do
        expect(client.fetch_next).to eq(nil)
      end
    end
  end
end
