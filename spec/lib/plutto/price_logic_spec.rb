require 'plutto/resources/price_logic'

RSpec.describe Plutto::PriceLogic do
  let(:data) do
    {
      id: "price-logic_0ce38b40f4c1752412ac3b72",
      type: "FlatFee",
      price: "15000.0",
      price_currency: "CLP",
      meter_count_method: nil,
      tiers: nil
    }
  end

  let(:price_logic) { described_class.new(**data) }

  it 'create an instance of PriceLogic' do
    expect(price_logic).to be_an_instance_of(described_class)
  end
end
