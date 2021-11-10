require 'plutto/client'

RSpec.describe Plutto::ClientSubscription do
  let(:api_key) { 'sk_live_0a641854b17cdfed9e98eb7cd3e9e2bfc2687a37470cc8ce71f31c49e33d037f' }
  let(:client) { described_class.new(api_key) }
  let(:subscription_id) { 'subscription_f6e7874cf5a4a8b6d396cbb3' }
  let(:subscription_id_pricing) { 'subscription_b6144cb887f20acc7a56be89' }
  let(:pricing_id) { 'pricing_ea1f7c8c15bee31736d12242' }

  let(:subscription_data) do
    {
      pricing_ids: [pricing_id],
      billing_period_duration: 'P0Y1M0DT0H0M0S',
      customer_id: 'customer_7439352cf50e2616ef8d997a',
      bills_at: 'start'
    }
  end

  describe '.new' do
    it 'create an instance Client' do
      expect(client).to be_an_instance_of(described_class)
    end
  end

  describe '#create_subscription' do
    it 'creates a subscription', :vcr do
      subscription = client.create_subscription(subscription_data)
      expect(subscription).to be_a(Plutto::Subscription)
      @subscription_created_id = subscription.id
    end

    it_behaves_like 'unauthorized endpoint', 'create_subscription' do
      let(:params) { subscription_data }
    end
    it_behaves_like 'unprocessable entity', 'create_subscription' do
      let(:params) do
        {
          pricing_ids: ["pricing_ea1f7c8c15bee31736d12242"],
          customer_id: 'customer_aa97aa3f9b0f6bc4b1c8a2a3'
        }
      end
    end
  end

  describe '#end_subscription' do
    it 'creates a end_subscription', :vcr do
      subscription = client.end_subscription(
        subscription_id: subscription_id
      )
      expect(subscription).to be_a(Plutto::Subscription)
    end

    it_behaves_like 'unauthorized endpoint', 'end_subscription' do
      let(:params) { { subscription_id: subscription_id } }
    end

    it_behaves_like 'resource not found', 'end_subscription' do
      let(:params) { { subscription_id: 'invalid_subscription_id' } }
    end
  end

  describe '#add_pricings' do
    it 'add pricings to subscription', :vcr do
      subscription = client.add_pricings(
        subscription_id: subscription_id_pricing,
        pricings: [pricing_id]
      )
      expect(subscription).to be_a(Plutto::Subscription)
    end

    it_behaves_like 'unauthorized endpoint', 'add_pricings' do
      let(:params) do
        {
          subscription_id: subscription_id_pricing,
          pricings: [pricing_id]
        }
      end
    end

    it_behaves_like 'resource not found', 'add_pricings' do
      let(:params) do
        {
          subscription_id: 'invalid_subscription_id',
          pricings: ['invalid_pricing_id']
        }
      end
    end
  end

  describe '#remove_pricings' do
    it 'remove pricings from a subscription', :vcr do
      subscription = client.remove_pricings(
        subscription_id: subscription_id_pricing,
        pricings: [pricing_id]
      )
      expect(subscription).to be_a(Plutto::Subscription)
    end

    it_behaves_like 'unauthorized endpoint', 'remove_pricings' do
      let(:params) do
        {
          subscription_id: subscription_id_pricing,
          pricings: [pricing_id]
        }
      end
    end

    it_behaves_like 'resource not found', 'remove_pricings' do
      let(:params) do
        {
          subscription_id: 'invalid_subscription_id',
          pricings: ['invalid_pricing_id']
        }
      end
    end
  end
end
