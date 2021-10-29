require 'plutto/client'
require 'plutto/resources/customer'
require 'plutto/resources/invoice'

RSpec.describe Plutto::Client do
  let(:api_key) { 'sk_live_0a641854b17cdfed9e98eb7cd3e9e2bfc2687a37470cc8ce71f31c49e33d037f' }
  let(:client) { described_class.new(api_key) }
  let(:customer_id) { 'ID_123' }
  let(:invoice_id) { 'invoice_5281dfee1bccb3a5c78f802e' }

  let(:billing_information) do
    {
      activity: nil,
      address: nil,
      city: nil,
      country_iso_code: 'CL',
      legal_name: nil,
      phone: nil,
      state: nil,
      tax_id: nil,
      zip: nil
    }
  end

  let(:customer_data) do
    {
      identifier: 'ID_123',
      email: 'test@gmail.com',
      billing_information: { country_iso_code: 'CL' },
      name: 'customer'
    }
  end

  let(:wrong_customer_data) do
    {
      email: 'wrongmail',
      billing_information: { country_iso_code: 'asd' }
    }
  end

  describe '.new' do
    it 'create an instance Client' do
      expect(client).to be_an_instance_of(described_class)
    end
  end

  describe '#create_customer' do
    it 'creates a customer given the required parameters', :vcr do
      customer = client.create_customer(customer_data)
      expect(customer).to be_a(Plutto::Customer)
      expect(customer.email).to eq('test@gmail.com')
      expect(customer.billing_information).to be_a(Plutto::BillingInformation)
    end

    it_behaves_like 'unauthorized endpoint', 'create_customer' do
      let(:params) { customer_data }
    end

    it_behaves_like 'unprocessable entity', 'create_customer' do
      let(:params) { wrong_customer_data }
    end
  end

  describe '#get_customer' do
    it 'get customer instance given customer id', :vcr do
      customer = client.get_customer(customer_id: customer_id)
      expect(customer).to be_a(Plutto::Customer)
    end

    it_behaves_like 'unauthorized endpoint', 'get_customer' do
      let(:params) { { customer_id: customer_id } }
    end
    it_behaves_like 'resource not found', 'get_customer' do
      let(:params) { { customer_id: 'invalid_customer_id' } }
    end
  end

  describe '#update_customer' do
    it 'updates customer attributes', :vcr do
      customer = client.update_customer(
        customer_id: customer_id, name: 'updated', email: 'updated@gmail.com'
      )
      expect(customer).to be_a(Plutto::Customer)
      expect(customer.name).to eq('updated')
      expect(customer.email).to eq('updated@gmail.com')
    end

    it_behaves_like 'unauthorized endpoint', 'update_customer' do
      let(:params) { { customer_id: customer_id, name: 'updated', email: 'updated@gmail.com' } }
    end
  end

  describe '#delete_customer' do
    it 'deletes a customer given customer id', :vcr do
      content = client.delete_customer(customer_id: customer_id)
      expect(content).to eq(nil)
    end

    it_behaves_like 'unauthorized endpoint', 'delete_customer' do
      let(:params) { { customer_id: customer_id } }
    end
    it_behaves_like 'resource not found', 'delete_customer' do
      let(:params) { { customer_id: 'invalid_customer_id' } }
    end
  end

  describe '#get_customers' do
    it 'get all the customers instance', :vcr do
      customers = client.get_customers
      expect(customers).to all(be_a(Plutto::Customer))
    end

    it_behaves_like 'unauthorized endpoint', 'get_customers'
  end

  describe '#get_invoices' do
    it 'get all the invoices instance', :vcr do
      invoices = client.get_invoices
      expect(invoices).to all(be_a(Plutto::Invoice))
    end

    it_behaves_like 'unauthorized endpoint', 'get_invoices'
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
