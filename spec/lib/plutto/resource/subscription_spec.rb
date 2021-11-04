require 'plutto/resources/subscription'
require 'plutto/resources/pricing'

RSpec.describe Plutto::Subscription do
  let(:api_key) { 'sk_live_0a641854b17cdfed9e98eb7cd3e9e2bfc2687a37470cc8ce71f31c49e33d037f' }
  let(:client) { Plutto::Client.new(api_key) }
  let(:data) do
    {
      id: "subscription_1cc5fa39987c48d4dde5c122",
      customer_id: "customer_e9585b900c38db249f38f59c",
      created_at: "2021-10-20T15:03:35.144Z",
      updated_at: "2021-10-20T15:03:35.144Z",
      active: true,
      trial_finishes_at: nil,
      bills_at: nil,
      billing_period_duration: "P1M",
      pricings: [],
      permission_group: nil
    }
  end

  let(:subscription) { described_class.new(**data, client: client) }
  let(:pricing) do
    {
      id: "pricing_ea1f7c8c15bee31736d12242",
      name: "Básico",
      currency: "CLP",
      product_id: "product_cb870654623ffa74dc26c647",
      price_logics: [
        {
          id: "price-logic_0ce38b40f4c1752412ac3b72",
          type: "FlatFee",
          price: "15000.0",
          price_currency: "CLP",
          meter_count_method: nil,
          tiers: nil
        }
      ]
    }
  end

  it 'create an instance of Subscription' do
    expect(subscription).to be_an_instance_of(described_class)
    expect(subscription.pricings).to all(be_a(Plutto::Pricing))
  end

  it "print customer's id and since when its subcribed" do
    expect(subscription.to_s).to eq(
      "customer_e9585b900c38db249f38f59c is subscribed since 20 Oct 2021"
    )
  end

  describe '#end' do
    it 'calls end_subscription on client', :vcr do
      allow(client).to receive(:end_subscription).with(subscription_id: subscription.id)
      subscription.end
      expect(client).to have_received(:end_subscription).with(subscription_id: subscription.id).once
    end
  end

  describe '#add_pricings' do
    it 'calls add_pricings on client', :vcr do
      allow(client).to receive(:add_pricings).with(
        subscription_id: subscription.id, pricing_ids: [pricing[:id]]
      )
      subscription.add_pricings(pricing[:id])
      expect(client).to have_received(:add_pricings).with(
        subscription_id: subscription.id, pricing_ids: [pricing[:id]]
      ).once
    end
  end

  describe '#remove_pricings' do
    it 'calls remove_pricings on client', :vcr do
      allow(client).to receive(:remove_pricings).with(
        subscription_id: subscription.id, pricing_ids: [pricing[:id]]
      )
      subscription.remove_pricings(pricing[:id])
      expect(client).to have_received(:remove_pricings).with(
        subscription_id: subscription.id, pricing_ids: [pricing[:id]]
      ).once
    end
  end
end
