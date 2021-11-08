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

  describe '#create_instance' do
    let(:instance_data) do
      {
        customer_permission: {
          current_usage: 0,
          limit: nil,
          allowed: true,
          name: "Despachos"
        }
      }
    end
    it 'creates a CustomerPermission' do
      instance = Plutto::Utils.create_instance(instance_data)
      expect(instance).to be_a(Plutto::CustomerPermission)
    end
  end

  describe '#create_all_instance' do
    let(:many_instances_data) do
      {
        customers: [
          {
            id: "customer_e9585b900c38db249f38f59c",
            identifier: "a",
            name: "Phobos",
            email: "phobos@getplutto.com",
            created_at: "2021-09-24T17:29:43.914Z",
            updated_at: "2021-09-24T17:29:43.914Z"
          },
          {
            id: "customer_aa97aa3f9b0f6bc4b1c8a2a3",
            identifier: "customer_aa97aa3f9b0f6bc4b1c8a2a3",
            name: "Platanus",
            email: "contact@platan.us",
            created_at: "2021-10-04T14:11:12.015Z",
            updated_at: "2021-10-04T14:11:12.015Z"
          },
          {
            id: "customer_64b9534dd761b596aa7f05a8",
            identifier: "customer_64b9534dd761b596aa7f05a8",
            name: "Platanus",
            email: "contact@platan.us",
            created_at: "2021-10-04T18:22:41.529Z",
            updated_at: "2021-10-04T18:22:41.529Z"
          }
        ]
      }
    end

    it 'returns an array of Customer' do
      instance = Plutto::Utils.create_all_instances(many_instances_data)
      expect(instance).to all(be_a(Plutto::Customer))
    end
  end
end
