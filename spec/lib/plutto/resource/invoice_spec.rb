require 'plutto/resources/invoice'

RSpec.describe Plutto::Invoice do
  let(:api_key) { 'sk_live_0a641854b17cdfed9e98eb7cd3e9e2bfc2687a37470cc8ce71f31c49e33d037f' }
  let(:client) { Plutto::Client.new(api_key) }
  let(:invoice_id) { 'invoice_5281dfee1bccb3a5c78f802e' }

  let(:data) do
    {
      client: client,
      id: invoice_id,
      subtotal_cents: 0,
      tax_cents: 0,
      discount_cents: 0,
      currency: 'CLP',
      issue_date: '2021-10-20T15:03:35.113Z',
      created_at: '2021-10-20T15:03:35.121Z',
      updated_at: '2021-10-20T15:03:35.121Z',
      customer_id: 'customer_e9585b900c38db249f38f59c',
      status: 'created',
      payed_at: nil,
      payment_method: nil,
      tax_type: nil,
      document_id: nil,
      customer_name: 'Phobos',
      customer_email: 'phobos@getplutto.com',
      details: [
        {
          id: 'meter_5ef790a8ee1f2d1710cd2f13',
          type: 'per_unit',
          meter: 'Mudanzas',
          quantity: 0,
          description: '0 x Mudanzas',
          total_price: 0
        }
      ],
      billing_information: {
        city: 'Santiago',
        country_iso_code: nil,
        state: 'Metropolitana',
        address: 'Av. las condes 13240',
        zip: '7591393',
        tax_id: '19246648-2',
        activity: nil,
        legal_name: 'Plutto',
        phone: '+56992680522'
      },
      total: {
        cents: 0,
        currency_iso: 'CLP'
      }
    }
  end

  let(:invoice) { described_class.new(**data) }

  it 'create an instance of Invoice' do
    expect(invoice).to be_an_instance_of(described_class)
  end

  it "print the Invoice info when to_s is called" do
    expect(invoice.to_s).to eq("Phobos's invoice from 20 Oct 2021")
  end

  describe '#mark_as' do
    it 'calls invoice_mark_as on client', :vcr do
      allow(client).to receive(:invoice_mark_as).with(invoice_id: invoice.id, status: 'paid')
      invoice.mark_as(status: 'paid')
      expect(client).to have_received(:invoice_mark_as)
        .with(invoice_id: invoice.id, status: 'paid').once
    end
  end
end
