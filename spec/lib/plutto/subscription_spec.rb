require 'plutto/resources/subscription'
require 'plutto/resources/pricing'

RSpec.describe Plutto::Subscription do
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
      pricings: [
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
      ],
      permission_group: nil
    }
  end

  let(:subscription) { described_class.new(**data) }

  it 'create an instance of Subscription' do
    expect(subscription).to be_an_instance_of(described_class)
    expect(subscription.pricings).to all(be_a(Plutto::Pricing))
  end

  it "print customer's id and since when its subcribed" do
    expect(subscription.to_s).to eq(
      "customer_e9585b900c38db249f38f59c is subscribed since 20 Oct 2021"
    )
  end
end
