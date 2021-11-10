require 'plutto/resources/customer'
require 'plutto/resources/customer_permission'
require 'plutto/resources/meter_event'
require 'plutto/client'

class Plutto::ClientCustomer < Plutto::Client
  def create_customer(**params)
    post('customers', **params)
  end

  def get_customers
    all('customers')
  end

  def get_customer(customer_id:)
    get("customers/#{customer_id}")
  end

  def update_customer(customer_id:, **params)
    patch("customers/#{customer_id}", **params)
  end

  def delete_customer(customer_id:)
    delete("customers/#{customer_id}")
  end

  def get_customer_permission(customer_id:, permission_name:)
    get("customers/#{customer_id}/has_permission/#{permission_name}")
  end

  def create_meter_event(**params)
    post('meter_events', **params)
  end
end
