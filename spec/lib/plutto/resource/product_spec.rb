require 'plutto/resources/pricing'

RSpec.describe Plutto::Product do
  let(:data) do
    {
      id: 'product_cfe7a030450a816d311271cb',
      name: 'Producto transporte a empresas',
      meter: {
        id: 'meter_0c8008dbf7b2e48cf277987e',
        name: 'N° de despachos'
      },
      pricings: [
        {
          id: 'pricing_ac69388b6d914bf39783abf7',
          name: 'Chile ',
          currency: 'CLP',
          product_id: 'product_cfe7a030450a816d311271cb',
          price_logics: [
            {
              id: 'price-logic_4eac85ee90bd41a2cd8bde12',
              type: 'PerUnit',
              price: '2300.0',
              price_currency: 'CLP',
              meter_count_method: 'period_sum',
              tiers: nil
            }
          ]
        }
      ]
    }
  end

  let(:product) { described_class.new(**data) }

  it 'create an instance of Pricing' do
    expect(product).to be_an_instance_of(described_class)
    expect(product.pricings).to all(be_a(Plutto::Pricing))
  end

  it 'print the Pricing name and currency when to_s is called' do
    expect(product.to_s).to eq('Product: Producto transporte a empresas')
  end
end
