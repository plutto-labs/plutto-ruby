require 'plutto/resources/billing_information'

RSpec.describe Plutto::BillingInformation do
  let(:data) do
    {
      city: 'Santiago',
      country_iso_code: nil,
      state: 'Metropolitana',
      address: 'Av. las condes 13240',
      zip: '7591393',
      tax_id: '19246648-2',
      activity: nil,
      legal_name: 'Plutto',
      phone: '+56992680522'
    }
  end

  let(:billing_information) { described_class.new(**data) }

  it 'create an instance of BillingInformation' do
    expect(billing_information).to be_an_instance_of(described_class)
  end
end
