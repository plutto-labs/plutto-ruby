require 'plutto/version'
require 'plutto/errors'

require 'plutto/clients/client_customer'
require 'plutto/clients/client_invoice'
require 'plutto/clients/client_permission_group'
require 'plutto/clients/client_product'
require 'plutto/clients/client_subscription'

class Plutto::Plutto
  def initialize(api_key)
    @customer = Plutto::ClientCustomer.new(api_key)
    @invoice = Plutto::ClientInvoice.new(api_key)
    @subscription = Plutto::ClientSubscription.new(api_key)
    @product = Plutto::ClientProduct.new(api_key)
    @permission_group = Plutto::ClientPermissionGroup.new(api_key)
  end

  # Products Routes

  def create_customer(**params)
    @customer.create_customer(**params)
  end

  def get_customers
    @customer.get_customers
  end

  def get_customer(id)
    @customer.get_customer(customer_id: id)
  end

  def update_customer(id, **params)
    @customer.update_customer(customer_id: id, **params)
  end

  def delete_customer(id)
    @customer.delete_customer(customer_id: id)
  end

  def get_customer_permission(id, name)
    @customer.get_customer_permission(customer_id: id, permission_name: name)
  end

  def create_meter_event(**params)
    @customer.create_meter_event(params)
  end

  # Invoices Routes

  def get_invoices(q_status = nil, q_customer = nil)
    @invoice.get_invoices(q_status: q_status, q_customer: q_customer)
  end

  def get_invoice(id)
    @invoice.get_invoice(invoice_id: id)
  end

  def invoice_mark_as(invoice_id, **params)
    @invoice.invoice_mark_as(invoice_id: invoice_id, **params)
  end

  # Permission Group Route

  def get_permission_groups
    @permission_group.get_permission_groups
  end

  # Product Route

  def get_products
    @product.get_products
  end

  # Subscription Routes

  def create_subscription(**params)
    @subscription.create_subscription(**params)
  end

  def end_subscription(id)
    @subscription.end_subscription(subscription_id: id)
  end

  def add_pricings(id, **params)
    @subscription.add_pricings(subscription_id: id, **params)
  end

  def remove_pricings(id, **params)
    @subscription.remove_pricings(subscription_id: id, **params)
  end
end
