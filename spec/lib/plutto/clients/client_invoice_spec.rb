require 'plutto/client'

RSpec.describe Plutto::ClientInvoice do
  let(:api_key) { 'sk_live_0a641854b17cdfed9e98eb7cd3e9e2bfc2687a37470cc8ce71f31c49e33d037f' }
  let(:client) { described_class.new(api_key) }
  let(:invoice_id) { 'invoice_5281dfee1bccb3a5c78f802e' }

  describe '.new' do
    it 'create an instance Client' do
      expect(client).to be_an_instance_of(described_class)
    end
  end

  describe '#get_invoices' do
    it 'get all the invoices instance', :vcr do
      invoices = client.get_invoices(q_status: nil, q_customer: nil)
      expect(invoices).to all(be_a(Plutto::Invoice))
    end

    it_behaves_like 'unauthorized endpoint', 'get_invoices' do
      let(:params) { { q_status: nil, q_customer: nil } }
    end
  end

  describe '#get_invoice' do
    it 'get invoice instance given invoice id', :vcr do
      invoice = client.get_invoice(invoice_id: invoice_id)
      expect(invoice).to be_a(Plutto::Invoice)
    end

    it_behaves_like 'unauthorized endpoint', 'get_invoice' do
      let(:params) { { invoice_id: invoice_id } }
    end
    it_behaves_like 'resource not found', 'get_invoice' do
      let(:params) { { invoice_id: 'invalid_invoice_id' } }
    end
  end

  describe '#invoice_mark_as' do
    it 'get invoice instance given invoice id', :vcr do
      invoice = client.invoice_mark_as(invoice_id: invoice_id, status: 'paid')
      expect(invoice).to be_a(Plutto::Invoice)
      expect(invoice.status).to eq('paid')
    end

    it_behaves_like 'unauthorized endpoint', 'invoice_mark_as' do
      let(:params) { { invoice_id: invoice_id, status: 'paid' } }
    end
    it_behaves_like 'resource not found', 'invoice_mark_as' do
      let(:params) { { invoice_id: 'invalid_invoice_id', status: 'paid' } }
    end
  end
end
