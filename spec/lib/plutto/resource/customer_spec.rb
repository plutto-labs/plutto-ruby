require 'plutto/client'
require 'plutto/resources/customer'

RSpec.describe Plutto::Customer do
  let(:api_key) { 'sk_live_0a641854b17cdfed9e98eb7cd3e9e2bfc2687a37470cc8ce71f31c49e33d037f' }
  let(:client) { Plutto::Client.new(api_key) }
  let(:customer_id) { 'customer_083c6b82a1a33345086f1501' }
  let(:meter_id) { 'meter_5ef790a8ee1f2d1710cd2f13' }

  let(:customer_data) do
    {
      identifier: customer_id,
      email: nil,
      billing_information: nil,
      client: client,
      id: customer_id,
      name: nil,
      created_at: nil,
      updated_at: nil
    }
  end

  let(:meter_event_data) do
    {
      customer_id: customer_id,
      meter_id: meter_id,
      amount: 1,
      action: 'increment',
      timestamp: '2021-06-04 09:00'
    }
  end
  let(:customer) { described_class.new(customer_data) }

  describe '.new' do
    it 'create an instance Customer' do
      expect(customer).to be_an_instance_of(described_class)
    end
  end

  describe '#delete' do
    it 'calls delete_customer on client' do
      allow(client).to receive(:delete_customer).with(customer_id: customer_id)
      customer.delete
      expect(client).to have_received(:delete_customer).with(customer_id: customer_id).once
    end
  end

  describe '#meter_event' do
    it 'calls meter_event on client' do
      allow(client).to receive(:create_meter_event).with(**meter_event_data)
      customer.meter_event(*meter_event_data.values.drop(1))
      expect(client).to have_received(:create_meter_event).with(**meter_event_data).once
    end
  end
end
