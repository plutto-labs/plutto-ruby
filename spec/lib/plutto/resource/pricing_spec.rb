require 'plutto/resources/pricing'
require 'plutto/resources/price_logic'

RSpec.describe Plutto::Pricing do
  let(:data) do
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

  let(:pricing) { described_class.new(**data) }

  it 'create an instance of Pricing' do
    expect(pricing).to be_an_instance_of(described_class)
    expect(pricing.price_logics).to all(be_a(Plutto::PriceLogic))
  end

  it "print the Pricing name and currency when to_s is called" do
    expect(pricing.to_s).to eq("Pricing Básico [CLP]")
  end
end
