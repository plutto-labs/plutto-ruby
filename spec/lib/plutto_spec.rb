require 'plutto/client'

RSpec.describe Plutto::Plutto do
  let(:api_key) { 'sk_live_0a641854b17cdfed9e98eb7cd3e9e2bfc2687a37470cc8ce71f31c49e33d037f' }
  let(:client) { described_class.new(api_key) }

  let(:customer_client) { client.instance_variable_get(:@customer) }
  let(:invoice_client) { client.instance_variable_get(:@invoice) }
  let(:subscription_client) { client.instance_variable_get(:@subscription) }
  let(:product_client) { client.instance_variable_get(:@product) }
  let(:permission_group_client) { client.instance_variable_get(:@permission_group) }

  let(:customer_id) { 'customer_dde1c281812f0af2fd1ba08d' }
  let(:invoice_id) { 'invoice_5281dfee1bccb3a5c78f802e' }
  let(:subscription_id) { 'subscription_b6144cb887f20acc7a56be89' }
  let(:pricing_id) { 'pricing_ea1f7c8c15bee31736d12242' }
  let(:meter_id) { 'meter_5ef790a8ee1f2d1710cd2f13' }

  let(:meter_event_data) do
    {
      customer_id: customer_id,
      meter_id: meter_id,
      amount: 1,
      action: 'increment'
    }
  end

  let(:subscription_data) do
    {
      pricing_ids: ["pricing_ea1f7c8c15bee31736d12242"],
      billing_period_duration: 'P0Y1M0DT0H0M0S',
      customer_id: 'customer_aa97aa3f9b0f6bc4b1c8a2a3',
      bills_at: 'start'
    }
  end

  let(:customer_data) do
    {
      identifier: 'customer_dde1c281812f0af2fd1ba08d',
      email: 'test@gmail.com',
      billing_information: { country_iso_code: 'CL' },
      name: 'customer'
    }
  end

  describe '.new' do
    it 'create an instance Client' do
      expect(client).to be_an_instance_of(described_class)
      expect(customer_client).to be_a(Plutto::ClientCustomer)
      expect(invoice_client).to be_a(Plutto::ClientInvoice)
      expect(subscription_client).to be_a(Plutto::ClientSubscription)
      expect(product_client).to be_a(Plutto::ClientProduct)
      expect(permission_group_client)
        .to be_a(Plutto::ClientPermissionGroup)
    end
  end

  describe '#get_customers' do
    it_behaves_like 'plutto client test', 'get_customers' do
      let(:resource_client) { customer_client }
    end
  end

  describe '#create_customer' do
    it_behaves_like 'plutto client test with params', 'create_customer' do
      let(:resource_client) { customer_client }
      let(:params) { customer_data }
    end
  end

  describe '#get_customer' do
    it_behaves_like 'plutto client test with id', 'get_customer' do
      let(:resource_client) { customer_client }
      let(:id) { { customer_id: customer_id } }
    end
  end

  describe '#update_customer' do
    it_behaves_like 'plutto client test id and params', 'update_customer' do
      let(:resource_client) { customer_client }
      let(:params) { { customer_id: customer_id,  name: 'updated', email: 'updated@gmail.com' } }
    end
  end

  describe '#delete_customer' do
    it_behaves_like 'plutto client test with id', 'delete_customer' do
      let(:resource_client) { customer_client }
      let(:id) { { customer_id: customer_id } }
    end
  end

  describe '#get_customer_permission' do
    it_behaves_like 'plutto client test with id', 'get_customer_permission' do
      let(:resource_client) { customer_client }
      let(:id) { { customer_id: customer_id, permission_name: 'Despachos' } }
    end
  end

  describe '#create_meter_event' do
    it_behaves_like 'plutto client test with params', 'create_meter_event' do
      let(:resource_client) { customer_client }
      let(:params) { meter_event_data }
    end
  end

  describe '#get_permission_groups' do
    it_behaves_like 'plutto client test', 'get_permission_groups' do
      let(:resource_client) { permission_group_client }
    end
  end

  describe '#get_products' do
    it_behaves_like 'plutto client test', 'get_products' do
      let(:resource_client) { product_client }
    end
  end

  describe '#get_invoices' do
    it_behaves_like 'plutto client test with id', 'get_invoices' do
      let(:resource_client) { invoice_client }
      let(:id) { { q_status: nil, q_customer: nil } }
    end
  end

  describe '#get_invoice' do
    it_behaves_like 'plutto client test with id', 'get_invoice' do
      let(:resource_client) { invoice_client }
      let(:id) { { invoice_id: customer_id } }
    end
  end

  describe '#invoice_mark_as' do
    it_behaves_like 'plutto client test id and params', 'invoice_mark_as' do
      let(:resource_client) { invoice_client }
      let(:params) { { invoice_id: invoice_id, status: 'paid' } }
    end
  end

  describe '#create_subscription' do
    it_behaves_like 'plutto client test with params', 'create_subscription' do
      let(:resource_client) { subscription_client }
      let(:params) { subscription_data }
    end
  end

  describe '#end_subscription' do
    it_behaves_like 'plutto client test with id', 'end_subscription' do
      let(:resource_client) { subscription_client }
      let(:id) { { subscription_id: subscription_id } }
    end
  end

  describe '#add_pricings' do
    it_behaves_like 'plutto client test id and params', 'add_pricings' do
      let(:resource_client) { subscription_client }
      let(:params) { { subscription_id: subscription_id, pricings: [pricing_id] } }
    end
  end

  describe '#remove_pricings' do
    it_behaves_like 'plutto client test id and params', 'remove_pricings' do
      let(:resource_client) { subscription_client }
      let(:params) { { subscription_id: subscription_id, pricings: [pricing_id] } }
    end
  end
end
