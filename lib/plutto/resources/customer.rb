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
      @active_subscription = active_subscription
      @billing_information = billing_information
      @client = client
    end

    def delete
      @client.delete_customer(@id)
    end

    def to_s
      "Customer #{@name} #{@email}"
    end
  end
end
