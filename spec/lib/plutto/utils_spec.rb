require 'plutto/utils'
RSpec.describe Plutto::Utils do
  describe '#pick' do
    let(:dict) { { foo: 'Foo', bar: 'Bar', bazz: 'Bazz' } }

    it 'picks a key/value from a given hash' do
      picked = Plutto::Utils.pick(dict, 'bazz')
      expect(picked).to eq({ bazz: 'Bazz' })
    end

    it 'returns an Empty Hash when the key is not present' do
      picked = Plutto::Utils.pick(dict, 'blink')
      expect(picked).to eq({})
    end
  end

  describe '#concat_query_to_url' do
    shared_examples 'returns suffix' do |q_status, q_customer, result|
      it 'returns suffix' do
        suffix = Plutto::Utils.concat_query_to_url(q_status, q_customer)
        expect(suffix).to eq(result)
      end
    end

    context 'with both queries' do
      it_behaves_like 'returns suffix', 'q_status', 'q_customer',
                      "?q[status_eq]=q_status&q[customer_eq]=q_customer"
    end

    context 'with status query only' do
      it_behaves_like 'returns suffix', 'q_status', nil, "?q[status_eq]=q_status"
    end

    context 'with customer query only' do
      it_behaves_like 'returns suffix', nil, 'q_customer', "?q[customer_eq]=q_customer"
    end

    context 'with no queries' do
      it_behaves_like 'returns suffix', nil, nil, ''
    end
  end
end
