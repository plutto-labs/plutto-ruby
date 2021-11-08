require 'plutto/resources/billing_information'
require 'plutto/resources/subscription'

module Plutto
  class Customer
    attr_reader :id, :identifier, :name, :email, :created_at, :updated_at, :active_subscription,
                :billing_information

    def initialize(
      id:,
      identifier:,
      name:,
      email:,
      created_at:,
      updated_at:,
      active_subscription: nil,
      billing_information: nil,
      client: nil,
      **
    )
      @id = id
      @identifier = identifier
      @name = name
      @email = email
      @created_at = created_at
      @updated_at = updated_at
      @active_subscription = active_subscription && create_subscription(**active_subscription)
      @billing_information = billing_information && create_billing_information(billing_information)
      @client = client
    end

    def delete
      @client.delete_customer(customer_id: @id)
    end

    def meter_event(meter_id, amount, action, timestamp = nil)
      if timestamp.nil?
        @client.create_meter_event(customer_id: @id, meter_id: meter_id, amount: amount,
                                   action: action)
      else
        @client.create_meter_event(customer_id: @id, meter_id: meter_id, amount: amount,
                                   action: action, timestamp: timestamp)
      end
    end

    def permission(name)
      @client.get_customer_permission(customer_id: @id, permission_name: name)
    end

    def to_s
      "Customer #{@name} #{@email}"
    end

    private

    def create_subscription(data)
      Plutto::Subscription.new(**data, customer: self, client: @client)
    end

    def create_billing_information(data)
      Plutto::BillingInformation.new(**data, customer: self)
    end
  end
end
